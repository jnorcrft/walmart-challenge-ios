import UIKit
import Combine

final class LandingOverviewViewController: UIViewController {
  // MARK: - Properties

  private let viewModel: LandingOverviewViewModel
  private let collectionDataSource: LandingOverviewCollectionDataSource
  private let collectionDelegate: LandingOverviewCollectionDelegate
  private let viewLayout: LandingOverviewLayout

  private var cancellables: Set<AnyCancellable> = .init()
  private(set) var model: LandingOverviewModel?
  private(set) weak var coordinator: LandingCoordinating?

  // MARK: - Initializer & Lifecycle Methods

  init(
    viewModel: LandingOverviewViewModel,
    collectionDataSource: LandingOverviewCollectionDataSource = .init(),
    collectionDelegate: LandingOverviewCollectionDelegate = .init(),
    coordinator: LandingCoordinating
  ) {
    self.viewModel = viewModel
    self.collectionDataSource = collectionDataSource
    self.collectionDelegate = collectionDelegate
    self.coordinator = coordinator
    self.viewLayout = .init()
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    viewLayout.set(self)
    collectionDataSource.set(self)
    collectionDelegate.set(self)

    viewLayout.collectionView.dataSource = collectionDataSource
    viewLayout.collectionView.delegate = collectionDelegate
    viewLayout.layout()

    setBindings()

    Task {
      await viewModel.loadProducts()
    }
  }

  // MARK: - Private Methods

  private func setBindings() {
    viewModel.$state
      .receive(on: DispatchQueue.main)
      .sink { [weak self] state in
        self?.handleStateChange(state)
      }
      .store(in: &cancellables)

    viewModel.$cartCount
      .receive(on: DispatchQueue.main)
      .sink { [weak self] count in
        self?.coordinator?.updateCartCount(count)
      }
      .store(in: &cancellables)
  }
}

// MARK: - View Methods

extension LandingOverviewViewController: LandingOverviewViewProtocol {
  func handleStateChange(_ state: LandingOverviewViewModel.State) {
    switch state {
    case .loading:
      viewLayout.loadingView.startAnimating()
      viewLayout.collectionView.isHidden = true
    case .loaded(let model):
      viewLayout.loadingView.stopAnimating()
      viewLayout.collectionView.isHidden = false
      self.model = model
      viewLayout.collectionView.reloadData()
    case .error(let model):
      viewLayout.loadingView.stopAnimating()
      coordinator?.presentAlert(from: model, handler: { [weak self] in
        Task {
          await self?.viewModel.loadProducts()
        }
      })
    }
  }

  func showProductDetail(_ product: LandingProductModel) {
    let data = ProductDetailViewData(
      imageData: product.imageData,
      title: product.title,
      body: product.description,
      price: product.price,
      rating: product.rate,
      handler: .init(handler: { [weak self] _ in
        Task {
          await self?.viewModel.addToCart(product)
        }
      })
    )
    coordinator?.presentSheet(with: data)
  }

  func addToCart(_ product: LandingProductModel) {
    Task {
      await viewModel.addToCart(product)
    }
  }
}
