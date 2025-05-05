import UIKit

class CartFooterView: UIView {
  // MARK: - Properties

  private lazy var containerView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.layer.cornerRadius = 8
    view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    view.clipsToBounds = true
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .headline)
    label.numberOfLines = 1
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private lazy var actionButton: UIButton = {
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
    button.accessibilityLabel = "Purchase"
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  // MARK: - Initializer & Private Methods

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupViews()
  }

  // MARK: - Setup

  private func setupViews() {
    backgroundColor = .clear
    addSubview(containerView)
    containerView.addSubview(titleLabel)
    containerView.addSubview(actionButton)

    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(equalTo: self.topAnchor),
      containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

      titleLabel.topAnchor
        .constraint(equalTo: containerView.topAnchor, constant: 16),
      titleLabel.leadingAnchor
        .constraint(equalTo: containerView.leadingAnchor, constant: 16),
      titleLabel.trailingAnchor
        .constraint(equalTo: containerView.trailingAnchor, constant: -16),

      actionButton.topAnchor
        .constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
      actionButton.centerXAnchor
        .constraint(equalTo: containerView.centerXAnchor),
      actionButton.widthAnchor.constraint(equalToConstant: 200),
      actionButton.heightAnchor.constraint(equalToConstant: 44),
      actionButton.bottomAnchor
        .constraint(
          lessThanOrEqualTo: containerView.bottomAnchor,
          constant: -16
      )]
    )
  }

  // MARK: - Public Methods

  func configure(
    title: String,
    buttonTitle: String = "Purchase",
    action: UIAction? = nil
  ) {
    titleLabel.text = title
    if let action = action {
      actionButton.setTitle(buttonTitle, for: .normal)
      actionButton.addAction(action, for: .primaryActionTriggered)
    }
  }
}
