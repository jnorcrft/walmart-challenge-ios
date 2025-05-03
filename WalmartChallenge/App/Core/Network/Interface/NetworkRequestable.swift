import Foundation

protocol NetworkRequestable: AnyObject, Sendable {
  func request<Result: Decodable & Sendable>(
    urlString: String,
    httpMethod: HTTPMethod,
    timeoutInterval: TimeInterval
  ) async throws(NetworkClientError) -> Result

  func request(
    urlString: String,
    httpMethod: HTTPMethod,
    timeoutInterval: TimeInterval
  ) async throws(NetworkClientError) -> Data
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

  func request(
    urlString: String,
    httpMethod: HTTPMethod = .get,
    timeoutInterval: TimeInterval = 8
  ) async throws(NetworkClientError) -> Data {
    try await request(
      urlString: urlString,
      httpMethod: httpMethod,
      timeoutInterval: timeoutInterval
    )
  }
}
