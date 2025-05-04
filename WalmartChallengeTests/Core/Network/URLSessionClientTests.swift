import XCTest
@testable import WalmartChallenge

class URLSessionClientTests: XCTestCase {
  private var sut: NetworkRequestable!
  private var session: MockURLSession!

  override func setUp() {
    super.setUp()
    session = MockURLSession()
    sut = URLSessionClient(session: session)
  }

  override func tearDown() {
    session = nil
    sut = nil
    super.tearDown()
  }

  func test_client_requestSucceeds() async {
    session.jsonToReturn = "GET_NetworkClient_200"
    let urlString = "https://validurl.com"
    do {
      let request: DummyModel = try await sut.request(urlString: urlString)
      XCTAssertNotNil(request)
      XCTAssertEqual(request.id, 0)
    } catch {
      XCTFail("Succeeds expected")
    }
  }

  func test_client_requestFailure_serverErrorWithHTTPStatusCode400() async {
    session.statusCodeToReturn = 400
    session.jsonToReturn = "GET_NetworkClient_400"

    let exp = expectation(description: #function)
    let urlString = "https://validurl.com/foo/bar"

    do {
      let _: DummyModel = try await sut.request(urlString: urlString)
      XCTFail("Failure expected")
    } catch NetworkClientError.server(let error) {
      XCTAssertEqual(error.httpStatusCode, 400)
      XCTAssertEqual(error.message, "Bad Request")
      exp.fulfill()
    } catch {
      XCTFail("NetworkClientError.server expected")
    }
    await fulfillment(of: [exp], timeout: 8)
  }

  func test_client_requestFailure_serverErrorWithPlaceholder() async throws {
    session.statusCodeToReturn = 400
    session.jsonToReturn = "GET_NetworkClient_Humanized_400"

    let exp = expectation(description: #function)
    let urlString = "https://validurl.com/foo/bar"

    do {
      let _: DummyModel = try await sut.request(urlString: urlString)
      XCTFail("Failure expected")
    } catch NetworkClientError.server(let error) {
      let humanizedError = try XCTUnwrap(error.humanizedError)
      XCTAssertEqual(humanizedError.title, "Tu conexión a Internet no responde")
      XCTAssertEqual(humanizedError.message, "Para continuar, revisa tu conexión e intentalo de nuevo")
      XCTAssertEqual(humanizedError.primaryButtonTitle, "Reintentar")
      XCTAssertEqual(humanizedError.presentationStyle, "fullscreen")
      exp.fulfill()
    } catch {
      XCTFail("NetworkClientError.server expected")
    }
    await fulfillment(of: [exp], timeout: 8)
  }

  func test_client_requestFailure_invalidURL() async {
    let exp = expectation(description: #function)
    let urlString = ""

    do {
      let _: DummyModel = try await sut.request(urlString: urlString)
      XCTFail("Failure expected")
    } catch NetworkClientError.invalidURL(let urlString) {
      XCTAssertEqual(urlString, "")
      exp.fulfill()
    } catch {
      XCTFail("NetworkClientError.invalidURL expected")
    }
    await fulfillment(of: [exp], timeout: 8)
  }

  func test_client_requestFailure_clientWithDecodingError() async {
    session.jsonToReturn = "Decoding_Error"
    let exp = expectation(description: #function)
    let urlString = "https://validurl.com/foo/bar"

    do {
      let _: DummyModel = try await sut.request(urlString: urlString)
      XCTFail("Failure expected")
    } catch NetworkClientError.client(let error) {
      XCTAssertTrue(error is DecodingError)
      exp.fulfill()
    } catch {
      XCTFail("NetworkClientError.client expected")
    }
    await fulfillment(of: [exp], timeout: 8)
  }

  func test_client_requestFailure_clientWithDecodingErrorFromData() async {
    session.errorToThrow = URLError(.badServerResponse)
    let exp = expectation(description: #function)
    let urlString = "https://validurl.com/foo/bar"

    do {
      let _: Data = try await sut.request(urlString: urlString)
      XCTFail("Failure expected")
    } catch NetworkClientError.client(let error) {
      XCTAssertTrue(error is URLError)
      exp.fulfill()
    } catch {
      XCTFail("NetworkClientError.client expected")
    }
    await fulfillment(of: [exp], timeout: 8)
  }
}

extension URLSessionClientTests {
  struct DummyModel: Identifiable, Decodable {
    let id: Int
  }
}
