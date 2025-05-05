@testable import WalmartChallenge

final class MockLandingRepository: LandingRepositoryProviding, @unchecked Sendable {
  var didSuccess: Bool = true
  var errorToReturn: Error = HumanizedError.placeholder

  var didCallFetchProducts = false
  var didCallFetchProductsByCatgory = false
  var didCallFetchCategories = false

  func fetchProducts() async throws -> LandingOverviewModel {
    didCallFetchProducts = true
    if didSuccess {
      return .mock
    } else {
      throw errorToReturn
    }
  }

  func fetchProducts(by category: String) async throws -> LandingOverviewModel {
    didCallFetchProductsByCatgory = true
    if didSuccess {
      return .mock
    } else {
      throw errorToReturn
    }
  }

  func fetchCategories() async throws -> [String] {
    didCallFetchCategories = true
    if didSuccess {
      return ["electronics","jewelery","men's clothing","women's clothing"]
    } else {
      throw errorToReturn
    }
  }
}
