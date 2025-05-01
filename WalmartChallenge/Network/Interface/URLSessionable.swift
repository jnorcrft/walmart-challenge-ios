import Foundation

protocol URLSessionable: AnyObject {
  func data(for request: URLRequest) async throws -> (Data, URLResponse)
}


extension URLSession: URLSessionable {}
