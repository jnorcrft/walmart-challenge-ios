@MainActor
protocol LandingOverviewViewProtocol: AnyObject {
  var model: LandingOverviewModel? { get }

  func handleStateChange(_ state: LandingOverviewViewModel.State)
  func showProductDetail(_ product: LandingProductModel)
  func addToCart(_ product: LandingProductModel)
}
