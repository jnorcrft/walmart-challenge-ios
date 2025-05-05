import UIKit

final class RatingView: UIView {

  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.spacing = Layout.Spacing.spacing1
    stackView.distribution = .fill
    stackView.isAccessibilityElement = true
    return stackView
  }()

  private var starImageViews: [UIImageView] = []

  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }

  private func commonInit() {
    addSubview(stackView.autolayout())
    NSLayoutConstraint.activate(stackView.constraints(anchoredTo: self))

    for _ in .zero..<5 {
      let imageView = UIImageView()
      imageView.contentMode = .scaleAspectFit
      imageView.tintColor = .systemYellow
      imageView.translatesAutoresizingMaskIntoConstraints = false

      NSLayoutConstraint.activate([
        imageView.widthAnchor.constraint(equalToConstant: 16),
        imageView.heightAnchor.constraint(equalToConstant: 16)
      ])

      starImageViews.append(imageView)
      stackView.addArrangedSubview(imageView)
    }
  }

  func setRating(_ rating: Double) {
    let fullStars = Int(rating)
    let hasHalfStar = rating.truncatingRemainder(dividingBy: 1) >= 0.5

    for (index, imageView) in starImageViews.enumerated() {
      if index < fullStars {
        // Full star
        imageView.image = UIImage(systemName: "star.fill")
      } else if index == fullStars && hasHalfStar {
        // Half star
        imageView.image = UIImage(systemName: "star.leadinghalf.filled")
      } else {
        // Empty star
        imageView.image = UIImage(systemName: "star")
      }
    }
  }
}
