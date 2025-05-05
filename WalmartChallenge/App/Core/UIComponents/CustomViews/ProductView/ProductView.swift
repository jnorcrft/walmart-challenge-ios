import UIKit

final class ProductView: UIView {
  // MARK: - Properties

  private let cardView: CardView = {
    let cardView = CardView()
    cardView.contentStack.spacing = Layout.Spacing.spacing2
    cardView.contentStack.distribution = .fill
    cardView.contentStack.isAccessibilityElement = false
    return cardView
  }()

  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 8
    imageView.isAccessibilityElement = false
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 16, weight: .medium)
    label.numberOfLines = 3
    label.lineBreakMode = .byWordWrapping
    label.textAlignment = .left
    label.isAccessibilityElement = true
    label.translatesAutoresizingMaskIntoConstraints = false
    label.setContentCompressionResistancePriority(.required, for: .horizontal)
    label.setContentCompressionResistancePriority(.required, for: .vertical)
    return label
  }()

  private let subtitleLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 14, weight: .medium)
    label.numberOfLines = .zero
    label.lineBreakMode = .byWordWrapping
    label.textAlignment = .left
    label.isAccessibilityElement = true
    label.translatesAutoresizingMaskIntoConstraints = false
    label.setContentCompressionResistancePriority(.required, for: .horizontal)
    label.setContentCompressionResistancePriority(.required, for: .vertical)
    return label
  }()

  private let button: UIButton = {
    let button = UIButton(type: .system)
    var configuration = UIButton.Configuration.plain()
    configuration.image = UIImage(systemName: "plus.circle.fill")
    configuration.baseForegroundColor = .systemBlue
    configuration.contentInsets = .zero
    button.configuration = configuration
    button.contentHorizontalAlignment = .trailing
    button.isAccessibilityElement = true
    button.accessibilityLabel = "Agregar al carro"
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  private let childContentStack: UIStackView = {
    let stackView = UIStackView()
    stackView.spacing = Layout.Spacing.spacing2
    stackView.distribution = .fill
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.isAccessibilityElement = false
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

  private let bottomContentStack: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .equalSpacing
    stackView.isAccessibilityElement = false
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

  private lazy var headlineLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 24, weight: .bold)
    label.numberOfLines = 1
    label.lineBreakMode = .byWordWrapping
    label.textAlignment = .left
    label.isAccessibilityElement = true
    label.translatesAutoresizingMaskIntoConstraints = false
    label.setContentCompressionResistancePriority(.required, for: .horizontal)
    label.setContentCompressionResistancePriority(.required, for: .vertical)
    return label
  }()

  private var isVerticalLayout: Bool = false

  // MARK: - Initializer & Public Methods

  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }

  func configure(_ viewData: ProductViewData) {
    imageView.image = UIImage(data: viewData.image ?? Data())
    titleLabel.text = viewData.title
    subtitleLabel.text = viewData.subtitle
    headlineLabel.text = viewData.headline
    button.addAction(viewData.handler, for: .primaryActionTriggered)

    let needsHorizontalLayout = !viewData.headline.isEmpty

    if needsHorizontalLayout != isVerticalLayout {
      needsHorizontalLayout
      ? layoutStackHorizontally()
      : layoutStackVertically()
      isVerticalLayout = needsHorizontalLayout
    }

    setNeedsLayout()
    layoutIfNeeded()
  }

  func prepareForReuse() {
    button.removeTarget(nil, action: nil, for: .allEvents)
    imageView.image = nil
    titleLabel.text = nil
    subtitleLabel.text = nil
    headlineLabel.text = nil
  }
}

// MARK: - Private Methods

extension ProductView {
  private func commonInit() {
    addSubview(cardView.autolayout())
    var constraints: [NSLayoutConstraint] = cardView.constraints(anchoredTo: self)
    constraints.append(contentsOf: [
      imageView.widthAnchor.constraint(equalToConstant: 80),
      imageView.heightAnchor.constraint(equalToConstant: 80),
    ])
    NSLayoutConstraint.activate(constraints)

    layoutStackVertically()
  }

  private func layoutStackVertically() {
    cardView.contentStack.axis = .vertical
    cardView.contentStack.alignment = .center

    cleanSubviews()

    [subtitleLabel, button].forEach {
      bottomContentStack.addArrangedSubview($0)
    }

    [titleLabel, bottomContentStack].forEach {
      childContentStack.addArrangedSubview($0)
    }

    layoutCardViewArrangedSubviews()
  }

  private func layoutStackHorizontally() {
    cardView.contentStack.axis = .horizontal
    cardView.contentStack.alignment = .center

    cleanSubviews()

    bottomContentStack.addArrangedSubview(button)

    [headlineLabel, titleLabel, subtitleLabel, bottomContentStack].forEach {
      childContentStack.addArrangedSubview($0)
    }

    layoutCardViewArrangedSubviews()
  }

  private func cleanSubviews() {
    cardView.contentStack.arrangedSubviews.forEach {
      cardView.contentStack.removeArrangedSubview($0)
      $0.removeFromSuperview()
    }

    childContentStack.arrangedSubviews.forEach {
      childContentStack.removeArrangedSubview($0)
      $0.removeFromSuperview()
    }
  }

  private func layoutCardViewArrangedSubviews() {
    [imageView, childContentStack].forEach {
      cardView.contentStack.addArrangedSubview($0)
    }
  }
}
