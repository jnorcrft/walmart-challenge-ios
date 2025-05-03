import XCTest
@testable import WalmartChallenge

final class LandingRepositoryTests: XCTestCase {
  private var sut: (any LandingRepositoryProviding)!
  private var remoteDataSource: MockLandingRemoteDataSource!

  override func setUp() {
    super.setUp()
    remoteDataSource = .init(
      client: URLSessionClient(
        session: MockURLSession()
      )
    )
    sut = LandingRepository(
      remoteDataSource: remoteDataSource,
      dtoToProductMapper: .init(),
      productToOverviewMapper: .init()
    )
  }

  override func tearDown() {
    remoteDataSource = nil
    sut = nil
    super.tearDown()
  }

  func test_repository_fetchProductsSucceeds() async {
    remoteDataSource.didSuccess = true
    let exp = expectation(description: #function)
    do {
      let response: LandingOverviewModel = try await sut.fetchProducts()
      exp.fulfill()
      XCTAssertNotNil(response.featuredProduct)
      XCTAssertFalse(response.products.isEmpty)
    } catch {
      XCTFail("Success is expected")
    }
    await fulfillment(of: [exp], timeout: 8)
  }

  func test_repository_fetchProductByCategorySucceeds() async {
    remoteDataSource.didSuccess = true
    let exp = expectation(description: #function)
    do {
      let response: LandingOverviewModel = try await sut.fetchProducts(by: "jewelry")
      exp.fulfill()
      XCTAssertNotNil(response.featuredProduct)
      XCTAssertFalse(response.products.isEmpty)
    } catch {
      XCTFail("Success is expected")
    }
    await fulfillment(of: [exp], timeout: 8)
  }

  func test_repository_fetchProductsThrows_ServerError() async {
    remoteDataSource.didSuccess = false
    let exp = expectation(description: #function)
    do {
      let _: LandingOverviewModel = try await sut.fetchProducts()
      XCTFail("Failure is expected")
    } catch NetworkClientError.server(let error) {
      exp.fulfill()
      XCTAssertEqual(error.httpStatusCode, 400)
      XCTAssertNotNil(error.humanizedError)
    } catch {
      XCTFail("NetworkClientError.server is expected")
    }
    await fulfillment(of: [exp], timeout: 8)
  }

  func test_repository_fetchProductsThrows_EmptyProductList() async {
    remoteDataSource.didSuccess = true
    remoteDataSource.emptyResponse = true
    let exp = expectation(description: #function)
    do {
      let _: LandingOverviewModel = try await sut.fetchProducts()
      XCTFail("Failure is expected")
    } catch {
      exp.fulfill()
      XCTAssertEqual(error.localizedDescription, "The product list is empty")
    }
    await fulfillment(of: [exp], timeout: 8)
  }

  func test_repository_fetchCategoriesSucceeds() async {
    remoteDataSource.didSuccess = true
    let exp = expectation(description: #function)
    do {
      let response: [String] = try await sut.fetchCategories()
      exp.fulfill()
      XCTAssertFalse(response.isEmpty)
    } catch {
      XCTFail("Success is expected")
    }
    await fulfillment(of: [exp], timeout: 8)
  }

  func test_repository_fetchCategoriesThrows_ServerError() async {
    remoteDataSource.didSuccess = false
    let exp = expectation(description: #function)
    do {
      let _: [String] = try await sut.fetchCategories()
      XCTFail("Failure is expected")
    } catch NetworkClientError.server(let error) {
      exp.fulfill()
      XCTAssertEqual(error.httpStatusCode, 400)
      XCTAssertNotNil(error.humanizedError)
    } catch {
      XCTFail("NetworkClientError.server is expected")
    }
    await fulfillment(of: [exp], timeout: 8)
  }
}
