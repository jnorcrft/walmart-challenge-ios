@testable import WalmartChallenge

final class MockCartRepository: CartRepositoryProviding, @unchecked Sendable {
  var didCallFetchCart = false
  var didCallSaveCartItem = false
  var didCallUpdateCartItemQuantity = false
  var didCallRemoveCartItem = false
  var didCallClearCart = false

  var didSuccess = true

  func fetchCart() async throws -> CartSummaryModel {
    didCallFetchCart = true
    if didSuccess {
      return .mock
    } else {
      throw EncodingError.invalidValue(1, .init(codingPath: [], debugDescription: ""))
    }

  }
  
  func saveCartItem(_ item: ProductDTO) async throws {
    didCallSaveCartItem = true
    if !didSuccess {
      throw EncodingError.invalidValue(1, .init(codingPath: [], debugDescription: ""))
    }
  }
  
  func updateCartItemQuantity(itemID: Int, increment: Bool) async throws {
    didCallUpdateCartItemQuantity = true
  }
  
  func removeCartItem(itemID: Int) async throws {
    didCallRemoveCartItem = true
  }
  
  func clearCart() async throws {
    didCallClearCart = true
  }
}
