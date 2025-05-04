import XCTest
@testable import WalmartChallenge

@MainActor
class TabBarCoordinatorTests: XCTestCase {
  private var sut: TabBarCoordinator!

  override func setUp() {
    super.setUp()
    sut = TabBarCoordinator(window: .init())
    sut.start()
  }

  override func tearDown() {
    sut = nil
    super.tearDown()
  }

  func test_tabBarCoordinator_startRoutingToLanding() {
    XCTAssertTrue(sut.tabBarController.viewControllers?.first is UINavigationController)
  }

  func test_tabBarCoordinator_startStoringTwoCoordinators() {
    XCTAssertEqual(sut.childCoordinators.count, 2)
    XCTAssertTrue(sut.childCoordinators.first is LandingCoordinator)
    XCTAssertTrue(sut.childCoordinators[1] is CartCoordinator)
    XCTAssertTrue(sut.childCoordinators.first?.navigationController.topViewController is LandingOverviewViewController)
  }
}
