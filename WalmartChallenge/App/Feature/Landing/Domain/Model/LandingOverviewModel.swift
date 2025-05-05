struct LandingOverviewModel: Sendable {
  let featuredProduct: LandingProductModel
  let products: [LandingProductModel]
  var categories: [String] = []
}
