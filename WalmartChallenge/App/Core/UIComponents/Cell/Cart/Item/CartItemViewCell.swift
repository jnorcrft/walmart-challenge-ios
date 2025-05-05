import UIKit

final class CartItemViewCell: UITableViewCell {
  // MARK: - Properties

  private let cardView: CardView = {
    let cardView = CardView()
    cardView.contentStack.spacing = Layout.Spacing.spacing2
    cardView.contentStack.axis = .horizontal
    cardView.contentStack.alignment = .top
    cardView.contentStack.distribution = .fill
    cardView.contentStack.isAccessibilityElement = false
    return cardView
  }()

  private let childContentStack: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = Layout.Spacing.spacing2
    stackView.distribution = .fill
    stackView.isAccessibilityElement = false
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

  private let controlContentStack: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .equalSpacing
    stackView.isAccessibilityElement = false
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

  private let itemImageView: UIImageView = {
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
    label.font = .preferredFont(forTextStyle: .headline)
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
    label.font = .preferredFont(forTextStyle: .subheadline)
    label.numberOfLines = 1
    label.textAlignment = .left
    label.isAccessibilityElement = true
    label.translatesAutoresizingMaskIntoConstraints = false
    label.setContentCompressionResistancePriority(.required, for: .horizontal)
    label.setContentCompressionResistancePriority(.required, for: .vertical)
    return label
  }()

  private let removeButton: UIButton = {
    let button = UIButton(type: .system)
    var configuration = UIButton.Configuration.bordered()
    configuration.baseForegroundColor = .systemRed
    configuration.baseBackgroundColor = .clear
    configuration.background.strokeColor = .systemRed
    configuration.contentInsets = NSDirectionalEdgeInsets(
      top: Layout.Spacing.spacing1,
      leading: .zero,
      bottom: Layout.Spacing.spacing1,
      trailing: .zero
    )
    button.configuration = configuration
    button.contentHorizontalAlignment = .center
    button.isAccessibilityElement = true
    button.accessibilityLabel = "Remove from cart"
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  private let incrementButton: UIButton = {
    let button = UIButton(type: .system)
    var configuration = UIButton.Configuration.plain()
    configuration.image = UIImage(systemName: "plus.circle.fill")
    configuration.baseForegroundColor = .systemGreen
    configuration.contentInsets = .zero
    button.configuration = configuration
    button.contentHorizontalAlignment = .trailing
    button.isAccessibilityElement = true
    button.accessibilityLabel = "Add another unit to cart"
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  private let decrementButton: UIButton = {
    let button = UIButton(type: .system)
    var configuration = UIButton.Configuration.plain()
    configuration.image = UIImage(systemName: "minus.circle.fill")
    configuration.baseForegroundColor = .systemRed
    configuration.contentInsets = .zero
    button.configuration = configuration
    button.contentHorizontalAlignment = .trailing
    button.isAccessibilityElement = true
    button.accessibilityLabel = "Remove one unit from cart"
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  private let counterLabel: UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .headline)
    label.numberOfLines = 1
    label.textAlignment = .left
    label.isAccessibilityElement = true
    label.translatesAutoresizingMaskIntoConstraints = false
    label.setContentCompressionResistancePriority(.required, for: .horizontal)
    label.setContentCompressionResistancePriority(.required, for: .vertical)
    return label
  }()

  private var index: Int = .zero
  weak var delegate: CartItemViewDelegate?

  // MARK: - Initializer & Public Methods

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    commonInit()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }

  func configure(_ viewData: CartItemViewData) {
    selectionStyle = .none
    itemImageView.image = UIImage(data: viewData.image ?? Data())
    index = viewData.index
    titleLabel.text = viewData.title
    subtitleLabel.text = viewData.subtitle
    counterLabel.text = String(viewData.count)
    removeButton.setTitle(viewData.buttonTitle, for: .normal)

    removeButton.addAction(.init(handler: { [weak self] _ in
      guard let self else { return }
      self.delegate?.didTapButton(.remove, at: self.index)
    }), for: .primaryActionTriggered)
    decrementButton.addAction(.init(handler: { [weak self] _ in
      guard let self else { return }
      self.delegate?.didTapButton(.decrement, at: self.index)
    }), for: .primaryActionTriggered)
    incrementButton.addAction(.init(handler: { [weak self] _ in
      guard let self else { return }
      self.delegate?.didTapButton(.increment, at: self.index)
    }), for: .primaryActionTriggered)

    layoutStackHorizontally()

    setNeedsLayout()
    layoutIfNeeded()
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    removeButton.removeTarget(nil, action: nil, for: .allEvents)
    decrementButton.removeTarget(nil, action: nil, for: .allEvents)
    incrementButton.removeTarget(nil, action: nil, for: .allEvents)
    delegate = nil
    itemImageView.image = nil
    titleLabel.text = nil
    subtitleLabel.text = nil
  }
}

// MARK: - Private Methods

extension CartItemViewCell {
  private func commonInit() {
    contentView.addSubview(cardView.autolayout())
    var constraints: [NSLayoutConstraint] = cardView.constraints(anchoredToLayoutGuide: contentView.layoutMarginsGuide)
    constraints.append(contentsOf: [
      itemImageView.widthAnchor.constraint(equalToConstant: 150),
      itemImageView.heightAnchor.constraint(equalToConstant: 150),
    ])
    NSLayoutConstraint.activate(constraints)

    layoutStackHorizontally()
  }

  private func layoutStackHorizontally() {
    cleanSubviews()

    [decrementButton, counterLabel, incrementButton].forEach {
      controlContentStack.addArrangedSubview($0)
    }

    [titleLabel, subtitleLabel, removeButton, controlContentStack].forEach {
      childContentStack.addArrangedSubview($0)
    }

    [itemImageView, childContentStack].forEach {
      cardView.contentStack.addArrangedSubview($0)
    }
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

    controlContentStack.arrangedSubviews.forEach {
      childContentStack.removeArrangedSubview($0)
      $0.removeFromSuperview()
    }
  }
}
