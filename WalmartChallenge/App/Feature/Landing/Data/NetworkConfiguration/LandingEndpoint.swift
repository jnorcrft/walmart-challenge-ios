enum LandingEndpoint: EndpointProviding {
  case products
  case categories
  case categoryProducts

  var endpoint: String {
    switch self {
    case .products:
      "/products"
    case .categories:
      "/products/categories"
    case .categoryProducts:
      "/products/category/%@"
    }
  }
}
