import Foundation
@testable import WalmartChallenge

final class MockURLSession: URLSessionable, @unchecked Sendable {
  var jsonFileName: String?
  var givenStatusCode: Int = 200

  func data(for request: URLRequest) async throws -> (Data, URLResponse) {
    let bundle = Bundle(for: type(of: self))
    guard let fileURL = bundle.url(forResource: jsonFileName, withExtension: "json") else {
      throw NSError(
        domain: "MockURLSession",
        code: 404,
        userInfo: [NSLocalizedDescriptionKey: "JSON file not found: \(jsonFileName!).json"]
      )
    }
    let data = try Data(contentsOf: fileURL)
    let response = HTTPURLResponse(
      url: request.url!,
      statusCode: givenStatusCode,
      httpVersion: nil,
      headerFields: nil
    )!

    return (data, response)
  }
}
