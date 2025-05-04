final class LandingEnvironment {
  // MARK: - Properties

  private let networkEnvironment: NetworkEnvironment
  private let serviceEnvironment: ServiceEnvironment

  init(
    networkEnvironment: NetworkEnvironment,
    serviceEnvironment: ServiceEnvironment
  ) {
    self.networkEnvironment = networkEnvironment
    self.serviceEnvironment = serviceEnvironment
  }

  // MARK: - Data

  func makeRemoteDataSource() -> some LandingDataProviding {
    LandingRemoteDatasource(client: networkEnvironment.makeNetworkClient())
  }

  func makeRepository() -> some LandingRepository {
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

  // MARK: - ViewModel

  @MainActor
  func makeOverviewViewModel() -> LandingOverviewViewModel {
    LandingOverviewViewModel(
      useCase: makeGetLandingOverviewUseCase(),
      imageFetchingService: serviceEnvironment.makeImageFetchingService()
    )
  }
}
