import Foundation

@MainActor
final class LandingOverviewViewModel: ObservableObject {
  // MARK: - Overview State

  enum State {
    case loading
    case loaded(model: LandingOverviewModel)
    case error(HumanizedError)
  }

  // MARK: - Properties

  private let getLandingOverviewUseCase: GetLandingOverviewUseCase
  private let addProductToCartUseCase: AddProductToCartUseCase
  private let imageFetchingService: ImageFetching

  // MARK: - Observed Properties

  @Published var state: State = .loading
  @Published var cartCount: Int = .zero

  // MARK: - Initializer & Public Methods

  init(
    getLandingOverviewUseCase: GetLandingOverviewUseCase,
    addProductToCartUseCase: AddProductToCartUseCase,
    imageFetchingService: ImageFetching
  ) {
    self.getLandingOverviewUseCase = getLandingOverviewUseCase
    self.addProductToCartUseCase = addProductToCartUseCase
    self.imageFetchingService = imageFetchingService
  }

  func loadProducts() async {
    state = .loading
    do {
      let (overview, categories) = try await getLandingOverviewUseCase.execute()

      var updatedFeaturedProduct = overview.featuredProduct
      updatedFeaturedProduct.imageData = try await self.imageFetchingService.fetchImage(from: overview.featuredProduct.imageURL)

      let updatedProducts = try await withThrowingTaskGroup(of: LandingProductModel.self) { group in
        for product in overview.products {
          group.addTask {
            var updatedProduct = product
            updatedProduct.imageData = try await self.imageFetchingService.fetchImage(from: product.imageURL)
            return updatedProduct
          }
        }

        var results: [LandingProductModel] = []
        for try await updatedProduct in group {
          results.append(updatedProduct)
        }
        return results
      }

      let finalModel = LandingOverviewModel(
        featuredProduct: updatedFeaturedProduct,
        products: updatedProducts,
        categories: categories
      )

      state = .loaded(model: finalModel)

    } catch let error as ServerError {
      state = .error(error.humanizedError ?? .placeholder)
    } catch {
      state = .error(.placeholder)
    }
  }

  func addToCart(_ product: LandingProductModel) async {
    do {
      let cartCount: Int = try await addProductToCartUseCase.execute(with: product)
      self.cartCount = cartCount
    } catch {
      state = .error(.placeholder)
    }
  }
}
