@testable import WalmartChallenge

final class MockLandingRepository: LandingRepositoryProviding, @unchecked Sendable {
  var didSuccess: Bool = true
  let humanizedError = HumanizedError.placeholder

  func fetchProducts() async throws -> LandingOverviewModel {
    if didSuccess {
      return .mock
    } else {
      throw humanizedError
    }
  }

  func fetchProducts(by category: String) async throws -> LandingOverviewModel {
    if didSuccess {
      return .mock
    } else {
      throw humanizedError
    }
  }

  func fetchCategories() async throws -> [String] {
    if didSuccess {
      return ["electronics","jewelery","men's clothing","women's clothing"]
    } else {
      throw humanizedError
    }
  }
}
