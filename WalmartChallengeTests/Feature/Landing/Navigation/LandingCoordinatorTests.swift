import XCTest
@testable import WalmartChallenge

@MainActor
class LandingCoordinatorTests: XCTestCase {
  private var sut: LandingCoordinator!
  private var navigationController: MockUINavigationController!

  override func setUp() {
    super.setUp()
    navigationController = .init()
    sut = LandingCoordinator(navigationController: navigationController)
    sut.start()
  }

  override func tearDown() {
    navigationController = nil
    sut = nil
    super.tearDown()
  }

  func test_coordinator_startRoutingToOverviewView() {
    XCTAssertTrue(sut.navigationController.topViewController is LandingOverviewViewController)
  }

  func test_coordinator_presentCategoriesViewSucceeds() {
    sut.presentLandingCategories()
    XCTAssertTrue(navigationController.lastPresentedViewController is LandingCategoriesViewController)
  }
}
