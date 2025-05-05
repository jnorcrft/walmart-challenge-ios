import XCTest
@testable import WalmartChallenge

final class CartRepositoryTests: XCTestCase {
  private var sut: CartRepositoryProviding!
  private var localDataSource: MockPersistentStorage!

  override func setUp() {
    super.setUp()
    localDataSource = .init()
    sut = CartRepository(
      localDataSource: localDataSource,
      dtoToCartItemMapper: .init()
    )
  }

  override func tearDown() {
    localDataSource.removeAll()
    localDataSource = nil
    sut = nil
    super.tearDown()
  }

  func test_repository_fetchCartResultWithEmptyItemsSucceeds() async {
    let exp = expectation(description: #function)
    do {
      let response: CartSummaryModel = try await sut.fetchCart()
      exp.fulfill()
      XCTAssertTrue(response.items.isEmpty)
      XCTAssertEqual(response.totalPrice, "$0 CLP")
    } catch {
      XCTFail("Success is expected")
    }
    await fulfillment(of: [exp], timeout: 8)
  }

  func test_repository_fetchCartWithItemsSucceeds() async {
    let exp = expectation(description: #function)
    do {
      try await sut.saveCartItem(.mock(id: 1))
      let response: CartSummaryModel = try await sut.fetchCart()
      exp.fulfill()
      XCTAssertFalse(response.items.isEmpty)
      XCTAssertEqual(response.items.first?.totalPrice, 109.95)
      XCTAssertEqual(response.totalPrice, "$110 CLP")
    } catch {
      XCTFail("Success is expected")
    }
    await fulfillment(of: [exp], timeout: 8)
  }

  func test_repository_incrementCartItemQuantitySucceeds() async {
    let exp = expectation(description: #function)
    let id = 1
    do {
      try await sut.saveCartItem(.mock(id: id))
      try await sut.updateCartItemQuantity(itemID: id, increment: true)
      let response: CartSummaryModel = try await sut.fetchCart()
      exp.fulfill()
      XCTAssertFalse(response.items.isEmpty)
      XCTAssertEqual(response.itemCount, 2)
    } catch {
      XCTFail("Success is expected")
    }
    await fulfillment(of: [exp], timeout: 8)
  }

  func test_repository_incrementInexistentCartItemQuantityThrows() async {
    let exp = expectation(description: #function)
    let id = 1
    do {
      try await sut.updateCartItemQuantity(itemID: id, increment: true)
      XCTFail("Failure is expected")
    } catch {
      exp.fulfill()
      XCTAssertEqual(error.localizedDescription, "Item not found")
    }
    await fulfillment(of: [exp], timeout: 8)
  }

  func test_repository_decrementCartItemQuantity_ResultOnRemovingItemSucceeds() async {
    let exp = expectation(description: #function)
    let id = 1
    do {
      try await sut.saveCartItem(.mock(id: id))
      try await sut.updateCartItemQuantity(itemID: id, increment: false)
      let response: CartSummaryModel = try await sut.fetchCart()
      exp.fulfill()
      XCTAssertTrue(response.items.isEmpty)
      XCTAssertEqual(response.itemCount, .zero)
    } catch {
      XCTFail("Success is expected")
    }
    await fulfillment(of: [exp], timeout: 8)
  }

  func test_repository_decrementCartItemQuantitySucceeds() async {
    let exp = expectation(description: #function)
    let id = 1
    do {
      try await sut.saveCartItem(.mock(id: id))
      try await sut.saveCartItem(.mock(id: id))

      try await sut.updateCartItemQuantity(itemID: id, increment: false)
      let response: CartSummaryModel = try await sut.fetchCart()
      exp.fulfill()
      XCTAssertFalse(response.items.isEmpty)
      XCTAssertEqual(response.itemCount, 1)
    } catch {
      XCTFail("Success is expected")
    }
    await fulfillment(of: [exp], timeout: 8)
  }

  func test_repository_clearCartSucceeds() async {
    let exp = expectation(description: #function)
    let id = 1
    do {
      try await sut.saveCartItem(.mock(id: id))
      try await sut.clearCart()
      let response: CartSummaryModel = try await sut.fetchCart()
      exp.fulfill()
      XCTAssertTrue(response.items.isEmpty)
      XCTAssertEqual(response.totalPrice, "$0 CLP")
    } catch {
      XCTFail("Success is expected")
    }
    await fulfillment(of: [exp], timeout: 8)
  }
}
