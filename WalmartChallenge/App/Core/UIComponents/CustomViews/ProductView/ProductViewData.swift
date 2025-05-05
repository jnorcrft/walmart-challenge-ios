import UIKit

struct ProductViewData {
  let image: Data?
  let title: String
  let subtitle: String
  let headline: String
  let handler: UIAction
  let index: Int

  init(
    image: Data?,
    title: String,
    subtitle: String,
    headline: String = "",
    handler: UIAction,
    index: Int = .zero
  ) {
    self.image = image
    self.title = title
    self.subtitle = subtitle
    self.headline = headline
    self.handler = handler
    self.index = index
  }
}
