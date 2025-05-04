import UIKit

final class CartCoordinator: Coordinating {
  let navigationController: UINavigationController

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    routeToCartSummary()
  }
}

extension CartCoordinator: CartCoordinating {
  func routeToCartSummary() {
    let viewController = CartSummaryViewController()
    viewController.view.backgroundColor = .white
    navigationController.pushViewController(viewController, animated: true)
  }
}
