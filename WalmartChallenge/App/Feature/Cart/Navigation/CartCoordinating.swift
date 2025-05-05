@MainActor
protocol CartCoordinating: AnyObject, AlertPresenting {
  func routeToCartSummary()
  func showEmptyState()
  func updateCart(_ count: Int)
}
