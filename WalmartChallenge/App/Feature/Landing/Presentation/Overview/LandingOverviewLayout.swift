import UIKit
import Combine

@MainActor
final class LandingOverviewLayout {
  // MARK: - Properties

  private weak var viewController: LandingOverviewViewController?

  private(set) var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = Layout.Spacing.spacing2
    layout.minimumInteritemSpacing = Layout.Spacing.spacing2
    layout.sectionInset = UIEdgeInsets.inset(constant: Layout.Spacing.spacing2)

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.contentInset = UIEdgeInsets.inset(constant: Layout.Spacing.spacing2)
    collectionView.backgroundColor = .clear
    collectionView.register(ProductCollectionViewCell.self)
    return collectionView
  }()

  private(set) lazy var loadingView: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView(style: .large)
    indicator.hidesWhenStopped = true
    return indicator
  }()

  func set(_ viewController: LandingOverviewViewController) {
    self.viewController = viewController
  }

  // MARK: - Public Methods

  func layout() {
    guard let viewController, let view = viewController.view else {
      return
    }
    configureNavBarAppearance(for: viewController)

    view.addSubview(collectionView.autolayout())
    view.addSubview(loadingView.autolayout())
    NSLayoutConstraint.activate(collectionView.constraints(anchoredTo: view))
    NSLayoutConstraint.activate([
      loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }

  // MARK: - Private Methods

  private func configureNavBarAppearance(for viewController: UIViewController) {
    let imageConfiguration = UIImage.SymbolConfiguration(scale: .large)
    let imageView = UIImageView(image: .init(systemName: "storefront.fill", withConfiguration: imageConfiguration))
    imageView.contentMode = .scaleAspectFit

    let buttonAction = UIAction { [weak self] _ in
      self?.viewController?.coordinator?.presentLandingCategories()
    }

    let button = UIBarButtonItem(
      image: .init(systemName: "ellipsis.circle", withConfiguration: imageConfiguration),
      primaryAction: buttonAction
    )

    viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imageView)
    viewController.navigationItem.rightBarButtonItem = button

  }
}
