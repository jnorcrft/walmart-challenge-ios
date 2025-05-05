@MainActor
protocol LandingOverviewViewProtocol: AnyObject {
  var model: LandingOverviewModel? { get }

  func showProductDetail(_ product: LandingProductModel)
  func addToCart(_ product: LandingProductModel)
}
