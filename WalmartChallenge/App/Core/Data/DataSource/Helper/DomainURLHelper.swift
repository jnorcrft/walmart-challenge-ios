struct DomainURLHelper<Endpoint: Sendable> {
  private let baseURL: String

  init(baseURL: String = "https://fakestoreapi.com") {
    self.baseURL = baseURL
  }

  func makeURL(for endpoint: Endpoint) -> String {
    baseURL + "\(endpoint)"
  }
}
