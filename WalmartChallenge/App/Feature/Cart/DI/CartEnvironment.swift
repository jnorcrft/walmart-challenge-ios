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

  // MARK: - UseCase

  func makeGetCartProductsUseCase() -> GetCartProductsUseCase {
    GetCartProductsUseCase(repository: makeRepository())
  }

  func makeManageCartProductsUseCase() -> ManageCartProductsUseCase {
    ManageCartProductsUseCase(repository: makeRepository())
  }

  // MARK: - ViewModel

  @MainActor
  func makeCartSummaryViewModel() -> CartSummaryViewModel {
    CartSummaryViewModel(
      getCartProductsUseCase: makeGetCartProductsUseCase(),
      manageCartProductUseCase: makeManageCartProductsUseCase()
    )
  }
}
