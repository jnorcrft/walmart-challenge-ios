final class CartEnvironment {
  // MARK: - Properties

  private let storageEnvironment: StorageEnvironment

  init(storageEnvironment: StorageEnvironment) {
    self.storageEnvironment = storageEnvironment
  }

  // MARK: - Data

  func makeRepository() -> CartRepositoryProviding {
    CartRepository(
      localDataSource: storageEnvironment.makeLocalStorage(),
      dtoToCartItemMapper: makeDtoToCartItemMapper()
    )
  }

  // MARK: - Mapper

  func makeDtoToCartItemMapper() -> ProductDTOToCartItemModelMapper {
    ProductDTOToCartItemModelMapper()
  }

//  func makeProductToOverviewMapper() -> LandingProductToOverviewModelMapper {
//    LandingProductToOverviewModelMapper()
//  }

  // MARK: - UseCase

//  func makeGetLandingOverviewUseCase() -> GetLandingOverviewUseCase {
//    GetLandingOverviewUseCase(repository: makeRepository())
//  }
}
