struct ManageCartProductsUseCase {
  private let repository: CartRepositoryProviding

  init(repository: CartRepositoryProviding) {
    self.repository = repository
  }

  func remove(_ product: CartItemModel) async throws {
    try await repository.removeCartItem(itemID: product.id)
  }

  func incrementQuantity(of product: CartItemModel) async throws {
    try await repository.updateCartItemQuantity(itemID: product.id, increment: true)
  }

  func decrementQuantity(of product: CartItemModel) async throws {
    try await repository.updateCartItemQuantity(itemID: product.id, increment: false)
  }
}
