import UIKit

@MainActor
protocol AlertPresenting {
  func presentAlert(from humanizedError: HumanizedError, handler: @escaping () -> Void)
}

extension AlertPresenting where Self: Coordinating {
  func presentAlert(from humanizedError: HumanizedError, handler: @escaping () -> Void) {
    let alert = UIAlertController(
      title: humanizedError.title,
      message: humanizedError.message,
      preferredStyle: .alert
    )
    alert.addAction(
      UIAlertAction(title: humanizedError.primaryButtonTitle, style: .default) { _ in
        handler()
      }
    )
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    navigationController.present(alert, animated: true)
  }
}
