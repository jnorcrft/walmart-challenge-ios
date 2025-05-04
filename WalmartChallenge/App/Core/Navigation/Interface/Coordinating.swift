import UIKit

@MainActor
protocol Coordinating: AnyObject {
  var navigationController: UINavigationController { get }

  func start()
}
