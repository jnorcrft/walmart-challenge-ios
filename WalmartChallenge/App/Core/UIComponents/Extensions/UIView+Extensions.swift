import UIKit

extension UIView {

  static var defaultIdentifier: String {
    String(describing: self)
  }

  static func view(color: UIColor, isAccesible: Bool = false) -> UIView {
    let view = UIView()
    view.backgroundColor = color
    view.isAccessibilityElement = isAccesible
    return view
  }

  func constraints(anchoredTo view: UIView, padding: CGFloat = .zero, priority: UILayoutPriority = .required) -> [NSLayoutConstraint] {
    let insets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    let topConstraint = self.topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top)
    topConstraint.priority = priority
    let constraints = [
      topConstraint,
      self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left),
      self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -insets.right),
      self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom)
    ]
    return constraints
  }

  func constraints(anchoredToLayoutGuide layoutGuide: UILayoutGuide) -> [NSLayoutConstraint] {
    return [
      self.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      self.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      self.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
      self.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor)
    ]
  }

  @discardableResult
  func autolayout() -> Self {
    self.translatesAutoresizingMaskIntoConstraints = false
    return self
  }
}
