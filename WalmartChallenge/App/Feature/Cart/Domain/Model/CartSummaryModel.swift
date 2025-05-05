import Foundation

struct CartSummaryModel: Sendable {
  let items: [CartItemModel]

  var totalPrice: String {
    let amount: Decimal = items.reduce(Decimal.zero) { accumulator, item in
      accumulator + (item.price * Decimal(item.quantity))
    }
    return "Total amount: \(CurrencyFormatter.formatToCLP(amount))"
  }

  var itemCount: Int {
    let count: Int = items.reduce(.zero) { accumulator, item in
      accumulator + item.quantity
    }
    return count
  }
}
