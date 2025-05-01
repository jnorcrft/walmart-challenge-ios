import Foundation

protocol NetworkRequestable: AnyObject {
  func request<Result: Decodable>(urlString: String, httpMethod: HTTPMethod, timeoutInterval: TimeInterval) async throws -> Result
}
