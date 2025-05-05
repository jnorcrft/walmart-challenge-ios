import Foundation

actor CartRepository: CartRepositoryProviding {
  private let localDataSource: StoragePersisting
  private let dtoToCartItemMapper: ProductDTOToCartItemModelMapper

  init(
    localDataSource: StoragePersisting,
    dtoToCartItemMapper: ProductDTOToCartItemModelMapper
  ) {
    self.localDataSource = localDataSource
    self.dtoToCartItemMapper = dtoToCartItemMapper
  }

  private enum StorageKeys {
      static let cartItems = "cart.repository.cartItems"
  }

  func fetchCart() async throws -> CartSummaryModel {
    let items: [CartItemModel] = try localDataSource.retrieve(forKey: StorageKeys.cartItems) ?? []
    let currentCart = CartSummaryModel(items: items)
    return currentCart
  }

  func saveCartItem(_ item: ProductDTO) async throws {
    var currentItems: [CartItemModel] = try await fetchCart().items

    let cartItem = dtoToCartItemMapper.map(value: item)

    if let index = currentItems.firstIndex(where: { $0.id == item.id }) {
      var existingItem = currentItems[index]
      existingItem.increment()
      currentItems[index] = existingItem
    } else {
      currentItems.append(cartItem)
    }

    try updateCart(with: currentItems)
  }

  func updateCartItemQuantity(itemID: Int, increment: Bool) async throws {
    var currentItems: [CartItemModel] = try await fetchCart().items

    guard let index = currentItems.firstIndex(where: { $0.id == itemID }) else {
      throw NSError(
        domain: "CartRepository",
        code: 404,
        userInfo: [NSLocalizedDescriptionKey: "Item not found"]
      )
    }

    var cartItem = currentItems[index]
    if increment {
      cartItem.increment()
    } else {
      let shouldKeepItem = cartItem.decrement()
      if !shouldKeepItem {
        try await removeCartItem(itemID: itemID)
        return
      }
    }
    currentItems[index] = cartItem

    try updateCart(with: currentItems)
  }

  func removeCartItem(itemID: Int) async throws {
    var currentItems: [CartItemModel] = try await fetchCart().items
    currentItems.removeAll(where: { $0.id == itemID })
    try updateCart(with: currentItems)
  }

  func clearCart() async throws {
    localDataSource.remove(forKey: StorageKeys.cartItems)
  }
}

extension CartRepository {
  private func updateCart(with items: [CartItemModel]) throws {
    let updatedCart = CartSummaryModel(items: items)
    try localDataSource.save(updatedCart.items, forKey: StorageKeys.cartItems)
  }
}
