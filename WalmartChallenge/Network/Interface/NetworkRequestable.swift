import Foundation

protocol NetworkRequestable: AnyObject, Sendable {
  func request<Result: Decodable & Sendable>(
    urlString: String,
    httpMethod: HTTPMethod,
    timeoutInterval: TimeInterval
  ) async throws(NetworkClientError) -> Result
}

extension NetworkRequestable {
  func request<Result: Decodable & Sendable>(
    urlString: String,
    httpMethod: HTTPMethod = .get,
    timeoutInterval: TimeInterval = 8
  ) async throws(NetworkClientError) -> Result {
    try await request(
      urlString: urlString,
      httpMethod: httpMethod,
      timeoutInterval: timeoutInterval
    )
  }
}
