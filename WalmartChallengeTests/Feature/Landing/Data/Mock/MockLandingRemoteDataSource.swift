@testable import WalmartChallenge

final class MockLandingRemoteDataSource: LandingDataProviding, @unchecked Sendable {
  let client: any NetworkRequestable
  let domain: DomainURLHelper<LandingEndpoint>

  var didSuccess: Bool = true
  var emptyResponse = false
  let error = NetworkClientError.server(.placeholder)

  init(client: any NetworkRequestable) {
    self.client = URLSessionClient(session: MockURLSession())
    self.domain = .init()
  }

  func fetchProducts() async throws(NetworkClientError) -> [ProductDTO] {
    if didSuccess {
      if !emptyResponse {
        return [.mock(id: 1), .mock(id: 2)]
      } else {
        return []
      }
    } else {
      throw error
    }
  }
  
  func fetchCategories() async throws(NetworkClientError) -> [String] {
    if didSuccess {
      return ["electronics","jewelery","men's clothing","women's clothing"]
    } else {
      throw error
    }
  }
  
  func fetchCategoryProducts(from category: String) async throws(NetworkClientError) -> [ProductDTO] {
    if didSuccess {
      return [.mock(id: 1), .mock(id: 2)]
    } else {
      throw error
    }
  }
}
