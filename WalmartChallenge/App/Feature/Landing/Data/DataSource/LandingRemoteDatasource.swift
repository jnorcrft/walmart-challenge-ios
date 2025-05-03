final class LandingRemoteDatasource: LandingDataProviding {
  let client: NetworkRequestable
  let domain: DomainURLHelper<LandingEndpoint>

  init(client: NetworkRequestable) {
    self.client = client
    self.domain = .init()
  }

  func fetchProducts() async throws(NetworkClientError) -> [ProductDTO] {
    let urlString = domain.makeURL(for: .products)
    let dto: [ProductDTO] = try await client.request(urlString: urlString)
    return dto
  }

  func fetchCategories() async throws(NetworkClientError) -> [String] {
    let urlString = domain.makeURL(for: .categories)
    let dto: [String] = try await client.request(urlString: urlString)
    return dto
  }

  func fetchCategoryProducts(from category: String) async throws(NetworkClientError) -> [ProductDTO] {
    let urlString = String(format: domain.makeURL(for: .categoryProducts), category)
    let dto: [ProductDTO] = try await client.request(urlString: urlString)
    return dto
  }
}
