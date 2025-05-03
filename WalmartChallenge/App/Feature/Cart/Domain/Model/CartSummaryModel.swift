import Foundation

struct CartSummaryModel: Sendable {
  let items: [CartItemModel]

  var totalPrice: String {
    let amount: Decimal = items.reduce(Decimal.zero) { accumulator, item in
      accumulator + (item.price * Decimal(item.quantity))
    }
    return CurrencyFormatter.formatToCLP(amount)
  }

  var itemCount: String {
    let count: Int = items.reduce(.zero) { accumulator, item in
      accumulator + item.quantity
    }
    return String(count)
  }
}
