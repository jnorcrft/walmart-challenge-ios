import UIKit
import Combine

final class CartSummaryViewController: UIViewController {
  // MARK: - Properties
  
  private let viewModel: CartSummaryViewModel
  private let tableDataSource: CartSummaryTableDataSource
  private let viewLayout: CartSummaryLayout
  private(set) weak var coordinator: CartCoordinating?

  private var cancellables: Set<AnyCancellable> = .init()
  private(set) var model: CartSummaryModel?

  // MARK: - Initializer & Lifecycle Methods
  
  init(
    viewModel: CartSummaryViewModel,
    tableDataSource: CartSummaryTableDataSource = .init(),
    viewLayout: CartSummaryLayout = .init(),
    coordinator: CartCoordinating
  ) {
    self.viewModel = viewModel
    self.tableDataSource = tableDataSource
    self.viewLayout = viewLayout
    self.coordinator = coordinator
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    prepareTableView()
    setBindings()
    Task {
      await viewModel.loadProducts()
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    Task {
      await viewModel.loadProducts()
    }
  }

  // MARK: - Private Methods

  private func prepareTableView() {
    tableDataSource.set(self)
    viewLayout.set(self)
    viewLayout.tableView.dataSource = tableDataSource
    viewLayout.layout()
  }

  private func setBindings() {
    viewModel.$state
      .receive(on: DispatchQueue.main)
      .sink { [weak self] state in
        self?.handleStateChange(state)
      }
      .store(in: &cancellables)
  }

  private func handleStateChange(_ state: CartSummaryViewModel.State) {
    switch state {
    case .loading:
      viewLayout.tableView.isHidden = true
      viewLayout.footerView.isHidden = true
    case .loaded(let model):
      viewLayout.tableView.isHidden = false
      viewLayout.footerView.isHidden = false
      self.model = model
      viewLayout.tableView.reloadData()
      updateFooter(withValue: model.totalPrice)
      coordinator?.updateCart(model.itemCount)
      navigationController?.contentUnavailableConfiguration = nil
    case .empty:
      coordinator?.showEmptyState()
      coordinator?.updateCart(.zero)
    case .error:
      coordinator?.presentAlert(from: .placeholder, handler: { [weak self] in
        Task {
          await self?.viewModel.loadProducts()
        }
      })
    }
  }
}

// MARK: - View Methods

extension CartSummaryViewController: CartSummaryViewProtocol {
  func didTapButton(_ type: CartItemButtonType, at index: Int) {
    Task {
      guard let model else { return }
      switch type {
      case .remove:
        await viewModel.manageProduct(.remove(item: model.items[index]))
      case .increment:
        await viewModel.manageProduct(.increment(item: model.items[index]))
      case .decrement:
        await viewModel.manageProduct(.decrement(item: model.items[index]))
      }
    }
  }

  func updateFooter(withValue value: String) {
    viewLayout.footerView.configure(
      title: value,
      action: UIAction { _ in
        #if DEBUG
        print("The End")
        #endif
      }
    )
  }
}
