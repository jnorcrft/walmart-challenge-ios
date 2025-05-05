import UIKit

extension UITableView {
  func register<T: UITableViewCell>(_ cellClass: T.Type) {
    register(cellClass, forCellReuseIdentifier: cellClass.defaultIdentifier)
  }

  func register<T: UITableViewHeaderFooterView>(_ cellClass: T.Type) {
    register(cellClass, forHeaderFooterViewReuseIdentifier: cellClass.defaultIdentifier)
  }

  func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withIdentifier: T.defaultIdentifier, for: indexPath) as? T else {
      fatalError("Could not dequeue cell with identifier: \(T.defaultIdentifier)")
    }
    return cell
  }

  func dequeueReusableCell<T: UITableViewHeaderFooterView>() -> T {
    guard let view = dequeueReusableHeaderFooterView(withIdentifier: T.defaultIdentifier) as? T else {
      fatalError("Could not dequeue header/footer view with identifier: \(T.defaultIdentifier)")
    }
    return view
  }
}
