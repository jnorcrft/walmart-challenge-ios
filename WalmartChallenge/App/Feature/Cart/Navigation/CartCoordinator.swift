import UIKit

final class CartCoordinator: Coordinating {
  let navigationController: UINavigationController
  private let environment: CartEnvironment
  weak var cartCountDelegate: CartCountUpdatingDelegate?

  init(
    navigationController: UINavigationController,
    environment: CartEnvironment
  ) {
    self.navigationController = navigationController
    self.environment = environment
  }

  func start() {
    routeToCartSummary()
    updateCart()
  }
}

extension CartCoordinator: CartCoordinating {
  func routeToCartSummary() {
    let viewController = CartSummaryViewController()
    viewController.view.backgroundColor = .white
    navigationController.pushViewController(viewController, animated: true)
  }

  func updateCart() {
    let repository = environment.makeRepository()
    Task {
      try await repository.clearCart()
      let cartCount = try await repository.fetchCart().itemCount
      cartCountDelegate?.updateCartCount(cartCount)
    }
  }
}
