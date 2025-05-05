struct GetCartProductsUseCase {
  private let repository: CartRepositoryProviding

  init(repository: CartRepositoryProviding) {
    self.repository = repository
  }

  func execute() async throws -> CartSummaryModel {
    try await repository.fetchCart()
  }
}
