import Foundation

struct LandingProductToOverviewModelMapper {
  func map(value: [LandingProductModel]) throws -> LandingOverviewModel {
    guard !value.isEmpty else {
      throw NSError(
        domain: "LandingProductToOverviewModelMapper",
        code: 1001,
        userInfo: [NSLocalizedDescriptionKey: "The product list is empty"]
      )
    }

    let featuredProduct = value.max { $0.score < $1.score }!
    let products = value.filter { $0.id != featuredProduct.id }

    return .init(featuredProduct: featuredProduct, products: products)
  }
}
