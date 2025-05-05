@testable import WalmartChallenge

extension CartSummaryModel {
  static var mock: Self {
    .init(
      items: [
        .init(
          id: 0,
          title: "title",
          price: 100.0
        )
      ]
    )
  }
}
