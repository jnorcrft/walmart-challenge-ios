struct ProductDTOToCartItemModelMapper {
  func map(value: ProductDTO) -> CartItemModel {
    .init(
      id: value.id,
      imageData: value.imageData,
      title: value.title,
      price: value.price
    )
  }
}
