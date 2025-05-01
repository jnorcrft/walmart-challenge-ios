import Foundation
@testable import WalmartChallenge

final class MockURLSession: URLSessionable {
  var responseObject: [String: Any]?
  var givenStatusCode: Int = 200

  func data(for request: URLRequest) async throws -> (Data, URLResponse) {
    let data = try JSONSerialization.data(withJSONObject: responseObject ?? [:])
    let response = HTTPURLResponse(
      url: request.url!,
      statusCode: givenStatusCode,
      httpVersion: nil,
      headerFields: nil
    )!
    return (data, response)
  }
}
