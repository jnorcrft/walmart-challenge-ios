import Foundation

actor URLSessionClient: NetworkRequestable {
  private let session: URLSessionable
  private let codableHelper: CodableHelper

  init(
    session: URLSessionable = URLSession.shared,
    codableHelper: CodableHelper = .init()
  ) {
    self.session = session
    self.codableHelper = codableHelper
  }

  func request<Result: Decodable & Sendable>(
    urlString: String,
    httpMethod: HTTPMethod = .get,
    timeoutInterval: TimeInterval = 8
  ) async throws(NetworkClientError) -> Result {
    let data = try await request(
      urlString: urlString,
      httpMethod: httpMethod,
      timeoutInterval: timeoutInterval
    )

    do {
      return try codableHelper.decodeNetworkObject(from: data)
    } catch {
      throw NetworkClientError.client(error)
    }
  }

  func request(
    urlString: String,
    httpMethod: HTTPMethod = .get,
    timeoutInterval: TimeInterval = 8
  ) async throws(NetworkClientError) -> Data {
    guard let url = URL(string: urlString) else {
      throw NetworkClientError.invalidURL(urlString)
    }

    var urlRequest = URLRequest(url: url, timeoutInterval: timeoutInterval)
    urlRequest.httpMethod = httpMethod.rawValue

    do {
      let (data, response) = try await session.data(for: urlRequest)

      guard
        let response = response as? HTTPURLResponse,
        HTTPStatusCode.isSuccess(from: response.statusCode)
      else {
        let error: ServerError? = try? codableHelper.decodeNetworkObject(from: data)
        throw NetworkClientError.server(error ?? .placeholder)
      }

      return data
    } catch let error as NetworkClientError {
      throw error
    } catch {
      throw NetworkClientError.client(error)
    }
  }
}
