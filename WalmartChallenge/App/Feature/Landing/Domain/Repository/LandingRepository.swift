final class LandingRepository: LandingRepositoryProviding {
  private let remoteDataSource: any LandingDataProviding
  private let dtoToProductMapper: ProductDTOToLandingProductModelMapper
  private let productToOverviewMapper: LandingProductToOverviewModelMapper

  init(
    remoteDataSource: any LandingDataProviding,
    dtoToProductMapper: ProductDTOToLandingProductModelMapper,
    productToOverviewMapper: LandingProductToOverviewModelMapper
  ) {
    self.remoteDataSource = remoteDataSource
    self.dtoToProductMapper = dtoToProductMapper
    self.productToOverviewMapper = productToOverviewMapper
  }

  func fetchProducts() async throws -> LandingOverviewModel {
    let value: [ProductDTO] = try await remoteDataSource.fetchProducts()
    let mappedValue: [LandingProductModel] = value.map { dtoToProductMapper.map(value: $0) }
    let model: LandingOverviewModel = try productToOverviewMapper.map(value: mappedValue)
    return model
  }

  func fetchProducts(by category: String) async throws -> LandingOverviewModel {
    let value: [ProductDTO] = try await remoteDataSource.fetchCategoryProducts(from: category)
    let mappedValue: [LandingProductModel] = value.map { dtoToProductMapper.map(value: $0) }
    let model: LandingOverviewModel = try productToOverviewMapper.map(value: mappedValue)
    return model
  }

  func fetchCategories() async throws -> [String] {
    try await remoteDataSource.fetchCategories()
  }
}
