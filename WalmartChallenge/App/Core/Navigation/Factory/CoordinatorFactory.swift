import UIKit

struct CoordinatorFactory {
  enum FeatureCoordinator {
    case landing, cart
  }

  @MainActor
  static func make(_ coordinator: FeatureCoordinator, with navigationController: UINavigationController) -> Coordinating {
    switch coordinator {
    case .landing:
      return LandingCoordinator(navigationController: navigationController)
    case .cart:
      return CartCoordinator(navigationController: navigationController)
    }
  }
}
