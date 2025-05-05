import UIKit

protocol SheetPresentable: UIView {
  var viewData: SheetDataComposable? { get }
  func configure(_ viewData: some SheetDataComposable)
  func setDismissalClosure(_ closure: @escaping () -> Void)
}
