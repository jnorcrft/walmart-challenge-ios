protocol LandingDataProviding: DataProviding {
  func fetchProducts() async throws(NetworkClientError) -> [ProductDTO]
  func fetchCategories() async throws(NetworkClientError) -> [String]
  func fetchCategoryProducts(from category: String) async throws(NetworkClientError) -> [ProductDTO]
}
