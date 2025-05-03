struct ProductDTOToCartItemModelMapper {
  func map(value: ProductDTO) -> CartItemModel {
    .init(
      id: value.id,
      title: value.title,
      price: value.price
    )
  }
}
