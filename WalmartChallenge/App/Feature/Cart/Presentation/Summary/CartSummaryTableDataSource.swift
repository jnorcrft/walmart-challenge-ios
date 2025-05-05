import UIKit

final class CartSummaryTableDataSource: NSObject {
  private weak var view: CartSummaryViewProtocol?

  func set(_ view: CartSummaryViewProtocol) {
    self.view = view
  }
}

// MARK: - UITableViewDataSource

extension CartSummaryTableDataSource: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    view?.model?.items.count ?? .zero
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    prepareCartItemViewCell(for: tableView, at: indexPath)
  }
}

// MARK: - Private Methods

extension CartSummaryTableDataSource {
  @MainActor
  private func prepareCartItemViewCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
    guard let model = view?.model else { return UITableViewCell() }
    let cell: CartItemViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
    cell.configure(
      .init(
        image: model.items[indexPath.row].imageData,
        title: model.items[indexPath.row].title,
        subtitle: model.items[indexPath.row].totalPrice,
        count: model.items[indexPath.row].quantity,
        index: indexPath.row
      )
    )
    cell.delegate = view
    cell.setNeedsLayout()
    cell.layoutIfNeeded()
    return cell
  }
}
