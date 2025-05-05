import XCTest
@testable import WalmartChallenge

@MainActor
class LandingOverviewViewModelTests: XCTestCase {
  private var sut: LandingOverviewViewModel!
  private var ladingRepository: MockLandingRepository!
  private var cartRepository: MockCartRepository!
  private var session: MockURLSession!
  private var viewController: LandingOverviewViewController!

  override func setUp() {
    super.setUp()
    session = MockURLSession()
    ladingRepository = MockLandingRepository()
    cartRepository = MockCartRepository()
    sut = .init(
      getLandingOverviewUseCase: .init(
        repository: ladingRepository
      ),
      addProductToCartUseCase: .init(
        repository: cartRepository,
        mapper: .init()
      ),
      imageFetchingService: ImageFetchingService(
        client: URLSessionClient(
          session: session
        )
      )
    )
    viewController = LandingOverviewViewController(
      viewModel: sut,
      coordinator: LandingCoordinator(
        environment: .init(
          networkEnvironment: .init(),
          serviceEnvironment: .init(networkEnvironment: .init()),
          cartEnvironment: .init(storageEnvironment: .init())
        ),
        navigationController: MockUINavigationController()
      )
    )
    viewController.loadView()
  }

  override func tearDown() {
    session = nil
    cartRepository = nil
    ladingRepository = nil
    sut = nil
    viewController = nil
    super.tearDown()
  }

  func test_viewModel_loadProductsSucceeds() async throws {
    await sut.loadProducts()
    XCTAssertEqual(sut.cartCount, .zero)
    XCTAssertTrue(ladingRepository.didCallFetchProducts)
    XCTAssertTrue(ladingRepository.didCallFetchCategories)
  }

  func test_viewModel_loadProductsByCategorySucceeds() async throws {
    await sut.loadProducts("Jewelery")
    XCTAssertEqual(sut.cartCount, .zero)
    XCTAssertTrue(ladingRepository.didCallFetchProductsByCatgory)
    XCTAssertTrue(ladingRepository.didCallFetchCategories)
  }

  func test_viewModel_loadProductsThrowsHumanizedError() async throws {
    ladingRepository.didSuccess = false
    await sut.loadProducts()
    XCTAssertTrue(ladingRepository.didCallFetchProducts)
    XCTAssertTrue(ladingRepository.didCallFetchCategories)
  }

  func test_viewModel_loadProductsThrowsServerError() async throws {
    ladingRepository.didSuccess = false
    ladingRepository.errorToReturn = ServerError.placeholder
    await sut.loadProducts()
    XCTAssertTrue(ladingRepository.didCallFetchProducts)
    XCTAssertTrue(ladingRepository.didCallFetchCategories)
  }

  func test_viewModel_addToCartSucceeds() async throws {
    await sut.addToCart(LandingOverviewModel.mock.featuredProduct)
    XCTAssertEqual(sut.cartCount, 1)
    XCTAssertTrue(cartRepository.didCallSaveCartItem)
    XCTAssertTrue(cartRepository.didCallFetchCart)
  }

  func test_viewModel_addToCartThrows() async throws {
    cartRepository.didSuccess = false
    await sut.addToCart(LandingOverviewModel.mock.featuredProduct)
    XCTAssertEqual(sut.cartCount, .zero)
    XCTAssertTrue(cartRepository.didCallSaveCartItem)
    XCTAssertFalse(cartRepository.didCallFetchCart)
  }
}
