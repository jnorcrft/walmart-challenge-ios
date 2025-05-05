import UIKit

@MainActor
final class TabBarCoordinator {
  private let window: UIWindow
  private(set) var tabBarController: UITabBarController
  private(set) var childCoordinators: [Coordinating] = []
  private var cartCountHelper: CartCountHelper?


  init(window: UIWindow) {
    self.window = window
    self.tabBarController = .init()
  }

  func start() {
    configureTabBarAppearance()
    setTabBarChildCoordinators()
  }
}

extension TabBarCoordinator {
  private func configureTabBarAppearance() {
    let appearance = UITabBarAppearance()
    appearance.configureWithOpaqueBackground()
    tabBarController.tabBar.standardAppearance = appearance
    tabBarController.tabBar.scrollEdgeAppearance = appearance
  }

  private func setTabBarChildCoordinators() {
    let landingCoordinator = CoordinatorFactory.make(.landing, with: UINavigationController())
    let cartCoordinator = CoordinatorFactory.make(.cart, with: UINavigationController())

    childCoordinators = [landingCoordinator, cartCoordinator]

    landingCoordinator.navigationController.tabBarItem = UITabBarItem(
      title: "Home",
      image: UIImage(systemName: "house"),
      selectedImage: UIImage(systemName: "house.fill")
    )

    cartCoordinator.navigationController.tabBarItem = UITabBarItem(
      title: "Cart",
      image: UIImage(systemName: "cart"),
      selectedImage: UIImage(systemName: "cart.fill")
    )

    childCoordinators.forEach { $0.start() }
    tabBarController.viewControllers = childCoordinators.map { $0.navigationController }

    cartCountHelper = .init(tabBarController: tabBarController)

    if let landingCoordinator = landingCoordinator as? LandingCoordinator? {
      landingCoordinator?.cartCountDelegate = cartCountHelper
    }

    if let cartCoordinator = cartCoordinator as? CartCoordinator? {
      cartCoordinator?.cartCountDelegate = cartCountHelper
    }

    window.rootViewController = tabBarController
    window.makeKeyAndVisible()
  }
}
