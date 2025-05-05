@MainActor
protocol LandingCoordinating: AnyObject, SheetPresenting {
  func routeToLandingOverview()
  func presentLandingCategories()
  func presentSheet(with details: ProductDetailViewData)
  func updateCartCount(_ count: Int)
}
