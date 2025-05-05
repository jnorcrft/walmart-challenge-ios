import UIKit

@MainActor
protocol SheetPresenting {
  func presentSheet(_ sheetView: SheetPresentable)
}

extension SheetPresenting where Self: Coordinating {
  func presentSheet(_ sheetView: SheetPresentable) {
    let viewController = SheetViewController(customView: sheetView)

    viewController.view.backgroundColor = .white

    if let sheet = viewController.sheetPresentationController {
      sheet.detents = [.medium()]
      sheet.preferredCornerRadius = 20
      sheet.prefersGrabberVisible = true
      sheet.largestUndimmedDetentIdentifier = nil
    }
    navigationController.present(viewController, animated: true)
  }
}
