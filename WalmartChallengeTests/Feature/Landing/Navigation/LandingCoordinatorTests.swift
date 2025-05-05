import XCTest
@testable import WalmartChallenge

@MainActor
class LandingCoordinatorTests: XCTestCase {
  private var sut: LandingCoordinator!
  private var navigationController: MockUINavigationController!

  override func setUp() {
    super.setUp()
    let networkEnvironment = NetworkEnvironment()
    let environment = LandingEnvironment(
      networkEnvironment: networkEnvironment,
      serviceEnvironment: .init(
        networkEnvironment: networkEnvironment
      ),
      cartEnvironment: .init(
        storageEnvironment: .init()
      )
    )
    navigationController = .init()
    sut = LandingCoordinator(
      environment: environment,
      navigationController: navigationController
    )
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

  func test_coordinator_presentSheetViewSucceeds() {
    let data = ProductDetailViewData(
      imageData: nil,
      title: "",
      body: "",
      price: "",
      rating: .zero,
      handler: .init(handler: { _ in })
    )
    sut.presentSheet(with: data)
    XCTAssertTrue(navigationController.lastPresentedViewController is SheetViewController)
  }

  func test_coordinator_presentAlertViewSucceeds() {
    sut.presentAlert(from: .placeholder, handler: {})
    XCTAssertTrue(navigationController.lastPresentedViewController is UIAlertController)
  }
}
