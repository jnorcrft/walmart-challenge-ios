import UIKit

protocol SheetDataComposable {
  var imageData: Data? { get }
  var title: String { get }
  var body: String { get }
  var handler: UIAction { get }
}
