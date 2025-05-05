import UIKit

final class CardView: UIView {
  // MARK: - Nested Types

  enum Padding: CGFloat {
    case small = 14.0
  }

  // MARK: - Public Properties

  var padding: Padding = .small {
    didSet {
      layoutMargins = UIEdgeInsets.inset(constant: padding.rawValue)
    }
  }

  let contentStack: UIStackView = .init()

  let contentBackdrop: UIView = {
    let view = UIView.view(color: .clear)
    view.clipsToBounds = true
    view.layer.cornerRadius = 8
    return view
  }()

  // MARK: - Private Properties

  private let borderLayer: CAShapeLayer = .init()
  private let borderWidth: CGFloat = 1
  private let borderRadius: CGFloat = 8

  // MARK: - Initializer & Private Methods

  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }

  override func layoutSublayers(of layer: CALayer) {
    super.layoutSublayers(of: layer)
    borderLayer.path = UIBezierPath(
      roundedRect: bounds.insetBy(dx: borderWidth / 2.0, dy: borderWidth / 2.0),
      cornerRadius: borderRadius
    ).cgPath
    borderLayer.frame = bounds
  }

  private func commonInit() {
    backgroundColor = .white
    padding = .small

    layer.borderWidth = .zero
    layer.cornerRadius = borderRadius
    if borderLayer.superlayer == nil {
      layer.addSublayer(borderLayer)
    }
    borderLayer.lineWidth = borderWidth
    borderLayer.fillColor = UIColor.clear.cgColor
    borderLayer.strokeColor = UIColor.systemGray4.cgColor
    borderLayer.lineDashPattern = nil

    addSubview(contentBackdrop.autolayout())
    contentBackdrop.addSubview(contentStack.autolayout())

    var constraints: [NSLayoutConstraint] = contentStack.constraints(anchoredToLayoutGuide: self.layoutMarginsGuide)
    constraints.append(contentsOf: contentBackdrop.constraints(anchoredToLayoutGuide: self.layoutMarginsGuide))
    NSLayoutConstraint.activate(constraints)
    sendSubviewToBack(contentBackdrop)
  }
}
