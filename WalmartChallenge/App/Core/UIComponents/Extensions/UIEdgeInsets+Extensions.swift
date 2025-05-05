import UIKit

extension UIEdgeInsets {
  static func inset(constant: CGFloat) -> Self {
    .init(top: constant, left: constant, bottom: constant, right: constant)
  }
}
