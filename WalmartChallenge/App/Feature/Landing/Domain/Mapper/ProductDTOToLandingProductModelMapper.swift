import Foundation

struct ProductDTOToLandingProductModelMapper {
  func map(value: ProductDTO) -> LandingProductModel {
    .init(
      id: value.id,
      title: value.title,
      price: CurrencyFormatter.formatToCLP(value.price),
      description: value.description,
      category: value.category,
      imageURL: value.imageURL,
      rate: value.rating.rate,
      rateCount: value.rating.count
    )
  }
}
