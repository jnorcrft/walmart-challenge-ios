@MainActor
protocol LandingCoordinating: AnyObject, SheetPresenting, AlertPresenting {
  func routeToLandingOverview()
  func presentSheet(with data: some SheetDataComposable)
  func updateCartCount(_ count: Int)
  func presentLandingCategories(with categories: [String])
  func didSelectCategory(_ category: String)
}
