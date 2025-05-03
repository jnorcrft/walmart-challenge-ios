import XCTest
@testable import WalmartChallenge

final class LandingRemoteDataSourceTests: XCTestCase {
  private var sut: (any LandingDataProviding)!
  private var session: MockURLSession!

  override func setUp() {
    super.setUp()
    session = MockURLSession()
    sut = LandingRemoteDatasource(
      client: URLSessionClient(session: session)
    )
  }

  override func tearDown() {
    session = nil
    sut = nil
    super.tearDown()
  }

  func test_remoteDataSource_fetchProductsSucceeds() async {
    session.statusCodeToReturn = 200
    session.jsonToReturn = "GET_FetchProducts_200"
    let exp = expectation(description: #function)
    do {
      let response: [ProductDTO] = try await sut.fetchProducts()
      exp.fulfill()
      XCTAssertFalse(response.isEmpty)
    } catch {
      XCTFail("Success is expected")
    }
    await fulfillment(of: [exp], timeout: 8)
  }

  func test_remoteDataSource_fetchProductsThrows() async {
    session.statusCodeToReturn = 400
    session.jsonToReturn = "GET_NetworkClient_Humanized_400"
    let exp = expectation(description: #function)
    do {
      let _: [ProductDTO] = try await sut.fetchProducts()
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

  func test_remoteDataSource_fetchCategoriesSucceeds() async {
    session.statusCodeToReturn = 200
    session.jsonToReturn = "GET_FetchCategories_200"
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

  func test_remoteDataSource_fetchCategoriesThrows() async {
    session.statusCodeToReturn = 400
    session.jsonToReturn = "GET_NetworkClient_Humanized_400"
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

  func test_remoteDataSource_fetchCategoryProductsSucceeds() async {
    session.statusCodeToReturn = 200
    session.jsonToReturn = "GET_FetchProducts_200"
    let exp = expectation(description: #function)
    do {
      let response: [ProductDTO] = try await sut.fetchCategoryProducts(from: "foo")
      exp.fulfill()
      XCTAssertFalse(response.isEmpty)
    } catch {
      XCTFail("Success is expected")
    }
    await fulfillment(of: [exp], timeout: 8)
  }

  func test_remoteDataSource_fetchCategoryProductsThrows() async {
    session.statusCodeToReturn = 400
    session.jsonToReturn = "GET_NetworkClient_Humanized_400"
    let exp = expectation(description: #function)
    do {
      let _: [ProductDTO] = try await sut.fetchCategoryProducts(from: "foo")
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
