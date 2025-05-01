import Foundation

protocol URLSessionable: AnyObject, Sendable {
  nonisolated func data(for request: URLRequest) async throws -> (Data, URLResponse)
}


extension URLSession: URLSessionable {}
