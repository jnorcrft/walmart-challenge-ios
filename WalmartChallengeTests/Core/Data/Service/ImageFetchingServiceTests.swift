import XCTest
@testable import WalmartChallenge

final class ImageFetchingServiceTests: XCTestCase {
  private var sut: ImageFetching!
  private var session: MockURLSession!
  
  override func setUp() {
    super.setUp()
    session = MockURLSession()
    sut = ImageFetchingService(
      client: URLSessionClient(session: session)
    )
  }
  
  override func tearDown() {
    session = nil
    sut = nil
    super.tearDown()
  }
  
  func test_fetchImage_returnsDataSucceeds() async throws {
    let expectedData = UIImage(systemName: "star.fill")?.pngData()
    session.statusCodeToReturn = 200
    session.dataToReturn = expectedData

    let response: Data = try await sut.fetchImage(from: "https://example.com/image.jpg")

    XCTAssertNotNil(response)
    XCTAssertEqual(response, expectedData)
  }

  func test_fetchImage_returnsEmptyDataSucceeds() async throws {
    let expectedData = Data()
    session.statusCodeToReturn = 200
    session.dataToReturn = expectedData

    let response: Data = try await sut.fetchImage(from: "https://example.com/image.jpg")

    XCTAssertNotNil(response)
    XCTAssertEqual(response, expectedData)
  }

  func test_fetchImage_withInvalidURLThrows() async throws {
    session.statusCodeToReturn = 400
    session.dataToReturn = nil

    do {
      let _: Data = try await sut.fetchImage(from: "")
    } catch {
      XCTAssertNotNil(error)
    }
  }
}
