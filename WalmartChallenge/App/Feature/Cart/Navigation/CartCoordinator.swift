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
  }
}

extension CartCoordinator: CartCoordinating {
  func showEmptyState() {
    var config = UIContentUnavailableConfiguration.empty()
    config.image = UIImage(systemName: "cart")
    config.text = "Your Cart is Empty"
    config.secondaryText = "Items you add to your cart will appear here"
    navigationController.contentUnavailableConfiguration = config
  }
  
  func routeToCartSummary() {
    let viewController = CartSummaryViewController(
      viewModel: environment.makeCartSummaryViewModel(),
      coordinator: self
    )
    viewController.view.backgroundColor = .white
    navigationController.pushViewController(viewController, animated: true)
  }

  func updateCart(_ count: Int) {
    cartCountDelegate?.updateCartCount(count)
  }
}
