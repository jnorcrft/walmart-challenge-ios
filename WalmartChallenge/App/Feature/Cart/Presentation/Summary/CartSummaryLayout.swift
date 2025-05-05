import UIKit

@MainActor
final class CartSummaryLayout {
  // MARK: - Properties

  private weak var viewController: CartSummaryViewController?

  let tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(CartItemViewCell.self)
    tableView.separatorStyle = .none
    return tableView
  }()

  let footerView: CartFooterView = {
    let view = CartFooterView()
    return view
  }()

  func set(_ viewController: CartSummaryViewController) {
    self.viewController = viewController
  }

  // MARK: - Public Methods

  func layout() {
    guard let view = viewController?.view else {
      return
    }

    view.addSubview(footerView.autolayout())
    NSLayoutConstraint.activate([
      footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      footerView.bottomAnchor
        .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      footerView.heightAnchor.constraint(equalToConstant: 120)
    ])


    view.addSubview(tableView.autolayout())
    NSLayoutConstraint.activate([
      tableView.topAnchor
        .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])

    tableView.contentInset = UIEdgeInsets(
      top: .zero,
      left: .zero,
      bottom: 120,
      right: .zero
    )
    tableView.scrollIndicatorInsets = tableView.contentInset
    view.bringSubviewToFront(footerView)
  }

  // MARK: - Private Methods
}
