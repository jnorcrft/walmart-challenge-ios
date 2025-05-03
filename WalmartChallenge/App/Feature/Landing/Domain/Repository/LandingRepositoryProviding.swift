protocol LandingRepositoryProviding: Sendable {
  func fetchProducts() async throws -> LandingOverviewModel
  func fetchProducts(by category: String) async throws -> LandingOverviewModel
  func fetchCategories() async throws -> [String]
}
