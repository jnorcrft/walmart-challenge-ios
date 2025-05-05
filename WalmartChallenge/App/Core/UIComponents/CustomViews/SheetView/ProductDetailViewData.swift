import UIKit

struct ProductDetailViewData: SheetDataComposable {
  let imageData: Data?
  let title: String
  let body: String
  let price: String
  let rating: Double
  let handler: UIAction
}
