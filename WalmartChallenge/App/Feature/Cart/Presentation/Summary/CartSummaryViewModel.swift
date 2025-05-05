import Foundation

@MainActor
final class CartSummaryViewModel: ObservableObject {
  // MARK: - Summary State

  enum State {
    case loading
    case loaded(model: CartSummaryModel)
    case empty
    case error
  }

  // MARK: - Summary Actions

  enum Action {
    case remove(item: CartItemModel)
    case increment(item: CartItemModel)
    case decrement(item: CartItemModel)
  }

  // MARK: - Properties

  private let getCartProductsUseCase: GetCartProductsUseCase
  private let manageCartProductUseCase: ManageCartProductsUseCase

  // MARK: - Observed Properties

  @Published var state: State = .loading

  // MARK: - Initializer & Public Methods

  init(
    getCartProductsUseCase: GetCartProductsUseCase,
    manageCartProductUseCase: ManageCartProductsUseCase
  ) {
    self.getCartProductsUseCase = getCartProductsUseCase
    self.manageCartProductUseCase = manageCartProductUseCase
  }

  func loadProducts() async {
    state = .loading
    do {
      let model: CartSummaryModel = try await getCartProductsUseCase.execute()
      state = model.items.isEmpty
        ? .empty
        : .loaded(model: model)
    } catch {
      state = .error
    }
  }

  func manageProduct(_ action: Action) async {
    state = .loading
    do {
      switch action {
      case .remove(let item):
        try await manageCartProductUseCase.remove(item)
      case .increment(let item):
        try await manageCartProductUseCase.incrementQuantity(of: item)
      case .decrement(let item):
        try await manageCartProductUseCase.decrementQuantity(of: item)
      }
      await loadProducts()
    } catch {
      state = .error
    }
  }
}
