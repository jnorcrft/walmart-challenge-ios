import Foundation
import UIKit

struct CartItemModel: Codable & Sendable {
  let id: Int
  let title: String
  let price: Decimal
  private(set) var quantity: Int

  private enum CodingKeys: String, CodingKey {
    case id, title, price, quantity
  }

  var image: UIImage?

  var totalPrice: String {
    let amount = price * Decimal(quantity)
    return CurrencyFormatter.formatToCLP(amount)
  }

  init(
    id: Int,
    title: String,
    price: Decimal,
    quantity: Int = 1,
    image: UIImage? = nil
  ) {
    self.id = id
    self.title = title
    self.price = price
    self.quantity = max(1, quantity)
    self.image = image
  }

  mutating func increment() {
    quantity += 1
  }

  mutating func decrement() -> Bool {
    guard quantity > 1 else {
      return false
    }
    self.quantity -= 1
    return true
  }
}
