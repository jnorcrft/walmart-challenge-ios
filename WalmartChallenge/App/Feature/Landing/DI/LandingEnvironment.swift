final class LandingEnvironment {
  // MARK: - Properties

  private let networkEnvironment: NetworkEnvironment
  private let serviceEnvironment: ServiceEnvironment
  private let cartEnvironment: CartEnvironment


  init(
    networkEnvironment: NetworkEnvironment,
    serviceEnvironment: ServiceEnvironment,
    cartEnvironment: CartEnvironment
  ) {
    self.networkEnvironment = networkEnvironment
    self.serviceEnvironment = serviceEnvironment
    self.cartEnvironment = cartEnvironment
  }

  // MARK: - Data

  func makeRemoteDataSource() -> some LandingDataProviding {
    LandingRemoteDatasource(client: networkEnvironment.makeNetworkClient())
  }

  func makeRepository() -> LandingRepositoryProviding {
    LandingRepository(
      remoteDataSource: makeRemoteDataSource(),
      dtoToProductMapper: makeDtoToProductMapper(),
      productToOverviewMapper: makeProductToOverviewMapper()
    )
  }

  // MARK: - Mapper

  func makeDtoToProductMapper() -> ProductDTOToLandingProductModelMapper {
    ProductDTOToLandingProductModelMapper()
  }

  func makeProductToOverviewMapper() -> LandingProductToOverviewModelMapper {
    LandingProductToOverviewModelMapper()
  }

  // MARK: - UseCase

  func makeGetLandingOverviewUseCase() -> GetLandingOverviewUseCase {
    GetLandingOverviewUseCase(repository: makeRepository())
  }

  func makeAddProductToCartUseCase() -> AddProductToCartUseCase {
    AddProductToCartUseCase(
      repository: cartEnvironment.makeRepository(),
      mapper: makeDtoToProductMapper()
    )
  }

  // MARK: - ViewModel

  @MainActor
  func makeOverviewViewModel() -> LandingOverviewViewModel {
    LandingOverviewViewModel(
      getLandingOverviewUseCase: makeGetLandingOverviewUseCase(),
      addProductToCartUseCase: makeAddProductToCartUseCase(),
      imageFetchingService: serviceEnvironment.makeImageFetchingService()
    )
  }
}
