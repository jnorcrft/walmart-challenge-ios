import XCTest
@testable import WalmartChallenge

@MainActor
class CartSummaryViewModelTests: XCTestCase {
  private var sut: CartSummaryViewModel!
  private var cartRepository: MockCartRepository!
  private var viewController: CartSummaryViewController!

  override func setUp() {
    super.setUp()
    cartRepository = MockCartRepository()
    sut = .init(
      getCartProductsUseCase: .init(repository: cartRepository),
      manageCartProductUseCase: .init(repository: cartRepository)
    )
    viewController = .init(
      viewModel: sut,
      coordinator: CartCoordinator(
        navigationController: MockUINavigationController(),
        environment: .init(
          storageEnvironment: .init()
        )
      )
    )
    viewController.loadView()
  }

  override func tearDown() {
    cartRepository = nil
    sut = nil
    viewController = nil
    super.tearDown()
  }

  func test_viewModel_loadProductsSucceeds() async throws {
    await sut.loadProducts()
    XCTAssertTrue(cartRepository.didCallFetchCart)
  }

  func test_viewModel_loadProductsThrowsEncodingError() async throws {
    cartRepository.didSuccess = false
    await sut.loadProducts()
    XCTAssertTrue(cartRepository.didCallFetchCart)
  }

  func test_viewModel_updateCartQuantitySucceeds() async throws {
    await sut.manageProduct(.increment(item: CartSummaryModel.mock.items.first!))
    await sut.manageProduct(.decrement(item: CartSummaryModel.mock.items.first!))
    XCTAssertTrue(cartRepository.didCallUpdateCartItemQuantity)
  }

  func test_viewModel_removeFromCartThrows() async throws {
    cartRepository.didSuccess = false
    await sut.manageProduct(.remove(item: CartSummaryModel.mock.items.first!))
    XCTAssertTrue(cartRepository.didCallRemoveCartItem)
  }
}
