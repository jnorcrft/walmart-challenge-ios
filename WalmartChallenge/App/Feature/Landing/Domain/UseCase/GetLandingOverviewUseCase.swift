struct GetLandingOverviewUseCase {
  private let repository: LandingRepositoryProviding

  init(repository: LandingRepositoryProviding) {
    self.repository = repository
  }

  func execute() async throws -> (LandingOverviewModel, [String]) {
    async let overview = try repository.fetchProducts()
    async let categories = try repository.fetchCategories()

    return try await (overview, categories)
  }
}
