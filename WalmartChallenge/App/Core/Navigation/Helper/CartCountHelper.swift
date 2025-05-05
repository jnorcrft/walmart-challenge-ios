import UIKit

final class CartCountHelper: CartCountUpdatingDelegate {
  private weak var tabBarController: UITabBarController?

  init(tabBarController: UITabBarController) {
    self.tabBarController = tabBarController
  }

  func updateCartCount(_ count: Int) {
    guard let tabBarItem = tabBarController?.tabBar.items?[1] else {
      return
    }
    tabBarItem.badgeValue = count > .zero ? "\(count)" : nil
    tabBarItem.badgeColor = .systemRed
  }
}
