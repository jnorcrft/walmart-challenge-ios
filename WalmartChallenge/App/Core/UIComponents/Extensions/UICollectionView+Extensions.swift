import UIKit

extension UICollectionView {
  func register<T: UICollectionViewCell>(_ cellClass: T.Type) {
    register(cellClass, forCellWithReuseIdentifier: cellClass.defaultIdentifier)
  }

  func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultIdentifier, for: indexPath) as? T else {
      fatalError("Could not dequeue cell with identifier: \(T.defaultIdentifier)")
    }
    return cell
  }
}
