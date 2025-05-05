import UIKit

struct CoordinatorFactory {
  private static let networkEnvironment = NetworkEnvironment()
  private static let serviceEnvironment = ServiceEnvironment(networkEnvironment: networkEnvironment)
  private static let storageEnvironment = StorageEnvironment()

  enum FeatureCoordinator {
    case landing, cart
  }

  @MainActor
  static func make(_ coordinator: FeatureCoordinator, with navigationController: UINavigationController) -> Coordinating {
    switch coordinator {
    case .landing:
      return LandingCoordinator(
        environment: .init(
          networkEnvironment: networkEnvironment,
          serviceEnvironment: serviceEnvironment,
          cartEnvironment: .init(storageEnvironment: storageEnvironment)
        ),
        navigationController: navigationController
      )
    case .cart:
      return CartCoordinator(
        navigationController: navigationController,
        environment: .init(storageEnvironment: storageEnvironment)
      )
    }
  }
}
