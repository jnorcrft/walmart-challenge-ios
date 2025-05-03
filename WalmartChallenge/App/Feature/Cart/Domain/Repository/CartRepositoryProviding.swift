protocol CartRepositoryProviding: Sendable {
  func fetchCart() async throws -> CartSummaryModel
  func saveCartItem(_ item: ProductDTO) async throws
  func updateCartItemQuantity(itemID: Int, increment: Bool) async throws
  func removeCartItem(itemID: Int) async throws
  func clearCart() async throws
}
