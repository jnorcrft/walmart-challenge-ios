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

  func reverseMap(value: LandingProductModel) -> ProductDTO {
    var result = ProductDTO(
      id: value.id,
      title: value.title,
      price: CurrencyFormatter.formatCLPBackToDecimal(value.price) ?? .zero,
      description: value.description,
      category: value.category,
      imageURL: value.imageURL,
      rating: .init(rate: value.rate, count: value.rateCount)
    )
    result.imageData = value.imageData
    return result
  }
}
