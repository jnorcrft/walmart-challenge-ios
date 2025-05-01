import Foundation

final class URLSessionClient: NetworkRequestable {
  private let session: URLSessionable
  private let codableHelper: CodableHelper

  init(
    session: URLSessionable = URLSession.shared,
    codableHelper: CodableHelper = .init()
  ) {
    self.session = session
    self.codableHelper = codableHelper
  }

  func request<Result: Decodable>(
    urlString: String,
    httpMethod: HTTPMethod = .get,
    timeoutInterval: TimeInterval = 8
  ) async throws -> Result {
    do {
      guard let url = URL(string: urlString) else {
        throw NetworkClientError.invalidURL(urlString)
      }

      var urlRequest = URLRequest(url: url, timeoutInterval: timeoutInterval)
      urlRequest.httpMethod = httpMethod.rawValue

      let (data, response) = try await session.data(for: urlRequest)

      guard
        let response = response as? HTTPURLResponse,
        HTTPStatusCode.isSuccess(from: response.statusCode)
      else {
        let error: ServerError? = try? codableHelper.decodeNetworkObject(from: data)
        throw NetworkClientError.server(error ?? .placeholder)
      }

      return try codableHelper.decodeNetworkObject(from: data)
    } catch let error where !(error is NetworkClientError) {
      throw NetworkClientError.client(error)
    } catch {
      throw error
    }
  }
}
