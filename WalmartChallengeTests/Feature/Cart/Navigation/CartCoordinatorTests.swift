import XCTest
@testable import WalmartChallenge

@MainActor
class CartCoordinatorTests: XCTestCase {
  private var sut: CartCoordinator!
  private var navigationController: MockUINavigationController!

  override func setUp() {
    super.setUp()
    navigationController = .init()
    sut = CartCoordinator(navigationController: navigationController)
    sut.start()
  }

  override func tearDown() {
    navigationController = nil
    sut = nil
    super.tearDown()
  }

  func test_coordinator_startRoutingToCartSummaryViewController() {
    XCTAssertTrue(sut.navigationController.topViewController is CartSummaryViewController)
  }
}
