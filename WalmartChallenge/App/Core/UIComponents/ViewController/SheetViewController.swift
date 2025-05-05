import UIKit

final class SheetViewController: UIViewController {
  private let customView: SheetPresentable

  init<T: SheetPresentable>(customView: T) {
    self.customView = customView
    super.init(nibName: nil, bundle: nil)

    customView.setDismissalClosure { [weak self] in
      self?.dismiss(animated: true)
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(customView.autolayout())
    NSLayoutConstraint.activate(customView.constraints(anchoredToLayoutGuide: view.safeAreaLayoutGuide))
  }
}
