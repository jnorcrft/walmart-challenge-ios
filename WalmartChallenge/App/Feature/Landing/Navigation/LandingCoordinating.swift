@MainActor
protocol LandingCoordinating: AnyObject, SheetPresenting, AlertPresenting {
  func routeToLandingOverview()
  func presentLandingCategories()
  func presentSheet(with data: some SheetDataComposable)
  func updateCartCount(_ count: Int)
}
