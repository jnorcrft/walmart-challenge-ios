import Foundation

final class ImageFetchingService: ImageFetching {
  private let client: NetworkRequestable

  init(client: NetworkRequestable) {
    self.client = client
  }

  func fetchImage(from urlString: String) async throws(NetworkClientError) -> Data {
    let data: Data = try await client.request(urlString: urlString)
    return data
  }
}
