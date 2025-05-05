@MainActor
protocol CartSummaryViewProtocol: CartItemViewDelegate {
  var model: CartSummaryModel? { get }
  func updateFooter(withValue value: String)
}
