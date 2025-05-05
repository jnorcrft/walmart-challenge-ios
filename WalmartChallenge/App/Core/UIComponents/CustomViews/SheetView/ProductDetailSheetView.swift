import UIKit

final class ProductDetailView: UIView, SheetPresentable {
  // MARK: - Properties

  private let contentStack: UIStackView = {
    let stackView = UIStackView()
    stackView.spacing = Layout.Spacing.spacing2
    stackView.axis = .vertical
    stackView.distribution = .fillProportionally
    stackView.isAccessibilityElement = false
    return stackView
  }()

  private let headingStack: UIStackView = {
    let stackView = UIStackView()
    stackView.spacing = Layout.Spacing.spacing2
    stackView.axis = .horizontal
    stackView.distribution = .equalSpacing
    stackView.isAccessibilityElement = false
    return stackView
  }()

  private let bottomStack: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .equalSpacing
    stackView.isAccessibilityElement = false
    return stackView
  }()

  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 8
    imageView.isAccessibilityElement = false
    return imageView
  }()

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 24, weight: .bold)
    label.numberOfLines = 3
    label.lineBreakMode = .byWordWrapping
    label.textAlignment = .left
    label.isAccessibilityElement = true
    label.setContentCompressionResistancePriority(.required, for: .horizontal)
    label.setContentCompressionResistancePriority(.required, for: .vertical)
    return label
  }()

  private let bodyLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 14, weight: .light)
    label.numberOfLines = .zero
    label.lineBreakMode = .byWordWrapping
    label.textAlignment = .left
    label.isAccessibilityElement = true
    label.setContentCompressionResistancePriority(.required, for: .horizontal)
    label.setContentCompressionResistancePriority(.required, for: .vertical)
    return label
  }()

  private let priceLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 14, weight: .light)
    label.numberOfLines = .zero
    label.lineBreakMode = .byWordWrapping
    label.textAlignment = .left
    label.isAccessibilityElement = true
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
    return button
  }()

  private let ratingView: RatingView = {
    let view = RatingView()
    view.isAccessibilityElement = true
    return view
  }()

  private(set) var viewData: SheetDataComposable?
  private var dismissClosure: (() -> Void)?

  // MARK: - Initializer & Public Methods

  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }

  func configure(_ viewData: some SheetDataComposable) {
    guard let viewData = viewData as? ProductDetailViewData else { return }
    self.viewData = viewData
    imageView.image = UIImage(data: viewData.imageData ?? Data())
    titleLabel.text = viewData.title
    bodyLabel.text = viewData.body
    ratingView.setRating(viewData.rating)
    button.addAction(.init(handler: { [weak self] action in
      self?.viewData?.handler.performWithSender(action.sender, target: nil)
      self?.dismissClosure?()
    }), for: .touchUpInside)
  }

  func setDismissalClosure(_ closure: @escaping () -> Void) {
      dismissClosure = closure
    }
}

// MARK: - Private Methods

extension ProductDetailView {
  private func commonInit() {
    backgroundColor = .white
    addSubview(contentStack.autolayout())
    NSLayoutConstraint.activate([
      contentStack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Layout.Spacing.spacing4),
      contentStack.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Layout.Spacing.spacing4),
      contentStack.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Layout.Spacing.spacing4),
      imageView.widthAnchor.constraint(equalToConstant: 120),
      imageView.heightAnchor.constraint(equalToConstant: 120),
    ])

    [titleLabel, priceLabel].forEach { headingStack.addArrangedSubview($0.autolayout()) }
    [ratingView, button].forEach { bottomStack.addArrangedSubview($0.autolayout()) }

    [imageView, headingStack, bodyLabel, bottomStack].forEach { contentStack.addArrangedSubview($0.autolayout()) }
  }
}
