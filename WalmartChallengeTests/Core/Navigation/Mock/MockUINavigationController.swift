import UIKit

final class MockUINavigationController: UINavigationController {
  var lastPushedViewController: UIViewController?
  var lastPresentedViewController: UIViewController?
  var dismissedViewController: UIViewController?

  var didCallDismiss = false

  override func pushViewController(_ viewController: UIViewController, animated: Bool) {
    lastPushedViewController = viewController
    super.pushViewController(viewController, animated: false)
  }

  override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
    lastPresentedViewController = viewControllerToPresent
    super.present(viewControllerToPresent, animated: false, completion: completion)
  }

  override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
    didCallDismiss = true
    dismissedViewController = presentedViewController
    super.dismiss(animated: false, completion: completion)
  }
}
