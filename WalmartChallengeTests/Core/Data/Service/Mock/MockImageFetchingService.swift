import Foundation
@testable import WalmartChallenge

final class MockImageFetchingService: ImageFetching, @unchecked Sendable {
  private let client: NetworkRequestable
  var dataToReturn: Data?
  var shouldThrowError: Bool = false

  init() {
    self.client = URLSessionClient(session: MockURLSession())
  }

  func fetchImage(from urlString: String) async throws(NetworkClientError) -> Data {
    if shouldThrowError {
      throw .server(.placeholder)
    }
    return dataToReturn ?? Data()
  }
}
