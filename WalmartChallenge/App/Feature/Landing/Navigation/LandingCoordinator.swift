import UIKit

final class LandingCoordinator: Coordinating {
  private let environment: LandingEnvironment
  let navigationController: UINavigationController
  weak var cartCountDelegate: CartCountUpdatingDelegate?
  weak var overviewViewController: LandingOverviewViewController?

  init(
    environment: LandingEnvironment,
    navigationController: UINavigationController
  ) {
    self.environment = environment
    self.navigationController = navigationController
  }

  func start() {
    routeToLandingOverview()
  }
}

extension LandingCoordinator: LandingCoordinating {
  func routeToLandingOverview() {
    let viewController = LandingOverviewViewController(
      viewModel: environment.makeOverviewViewModel(),
      coordinator: self
    )
    overviewViewController = viewController
    viewController.view.backgroundColor = .white
    navigationController.pushViewController(viewController, animated: true)
  }

  func presentSheet(with data: some SheetDataComposable) {
    if let data = data as? ProductDetailViewData {
      let sheetView = ProductDetailView()
      sheetView.configure(data)
      presentSheet(sheetView)
    }
  }

  func updateCartCount(_ count: Int) {
    cartCountDelegate?.updateCartCount(count)
  }

  func presentLandingCategories(with categories: [String]) {
    let viewController = LandingCategoriesViewController(
      categories: categories,
      coordinator: self
    )

    viewController.view.backgroundColor = .white
    viewController.isModalInPresentation = true
    viewController.modalPresentationStyle = .currentContext
    navigationController.present(viewController, animated: false)
  }

  func didSelectCategory(_ category: String) {
    overviewViewController?.didSelectCategory(category)
  }
}
