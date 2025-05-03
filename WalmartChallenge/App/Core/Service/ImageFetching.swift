import Foundation

protocol ImageFetching: AnyObject & Sendable {
  func fetchImage(from urlString: String) async throws(NetworkClientError) -> Data
}
