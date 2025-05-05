struct AddProductToCartUseCase {
  private let repository: CartRepositoryProviding
  private let mapper: ProductDTOToLandingProductModelMapper

  init(
    repository: CartRepositoryProviding,
    mapper: ProductDTOToLandingProductModelMapper
  ) {
    self.repository = repository
    self.mapper = mapper
  }

  func execute(with product: LandingProductModel) async throws -> Int {
    let dto = mapper.reverseMap(value: product)
    try await repository.saveCartItem(dto)
    return try await repository.fetchCart().itemCount
  }
}
