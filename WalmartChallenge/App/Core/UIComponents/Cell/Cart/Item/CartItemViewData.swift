import UIKit

struct CartItemViewData {
  let image: Data?
  let title: String
  let subtitle: String
  let buttonTitle: String
  let count: Int
  let index: Int

  init(
    image: Data?,
    title: String,
    subtitle: String,
    buttonTitle: String = "Quitar",
    count: Int,
    index: Int = .zero
  ) {
    self.image = image
    self.title = title
    self.subtitle = subtitle
    self.buttonTitle = buttonTitle
    self.count = count
    self.index = index
  }
}
