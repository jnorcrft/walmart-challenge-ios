import Foundation
@testable import WalmartChallenge

final class MockURLSession: URLSessionable, @unchecked Sendable {
  var jsonToReturn: String?
  var dataToReturn: Data?
  var statusCodeToReturn: Int = 200

  func data(for request: URLRequest) async throws -> (Data, URLResponse) {

    let data = jsonToReturn != nil
      ? try readJSON(jsonToReturn)
      : dataToReturn ?? Data()
    let response = HTTPURLResponse(
      url: request.url!,
      statusCode: statusCodeToReturn,
      httpVersion: nil,
      headerFields: nil
    )!

    return (data, response)
  }
}

extension MockURLSession {
  private func readJSON(_ fileName: String?) throws -> Data {
    let bundle = Bundle(for: type(of: self))
    guard let fileURL = bundle.url(forResource: fileName, withExtension: "json")
    else {
      throw NSError(
        domain: "MockURLSession",
        code: 404,
        userInfo: [
          NSLocalizedDescriptionKey:
            "JSON file not found: \(jsonToReturn!).json"
        ]
      )
    }
    return try Data(contentsOf: fileURL)
  }
}
