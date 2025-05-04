import UIKit

final class LandingCoordinator: Coordinating {
  let navigationController: UINavigationController

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    routeToLandingOverview()
  }
}

extension LandingCoordinator: LandingCoordinating {
  func routeToLandingOverview() {
    let viewController = LandingOverviewViewController()
    viewController.view.backgroundColor = .white
    configureNavBarAppearance(for: viewController)
    navigationController.pushViewController(viewController, animated: true)
  }

  func presentLandingCategories() {
    let viewController = LandingCategoriesViewController()
    viewController.view.backgroundColor = .white
    viewController.isModalInPresentation = true
    viewController.modalPresentationStyle = .currentContext
    navigationController.present(viewController, animated: false)
  }
}

extension LandingCoordinator {
  private func configureNavBarAppearance(for viewController: UIViewController) {
    let imageConfiguration = UIImage.SymbolConfiguration(scale: .large)
    let imageView = UIImageView(image: .init(systemName: "storefront.fill", withConfiguration: imageConfiguration))
    imageView.contentMode = .scaleAspectFit

    let buttonAction = UIAction { [weak self] _ in
      self?.presentLandingCategories()
    }

    let button = UIBarButtonItem(
      image: .init(systemName: "ellipsis.circle", withConfiguration: imageConfiguration),
      primaryAction: buttonAction
    )

    viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imageView)
    viewController.navigationItem.rightBarButtonItem = button

  }
}
