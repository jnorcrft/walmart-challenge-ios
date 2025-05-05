@testable import WalmartChallenge

extension LandingOverviewModel {
  static var mock: Self {
    .init(
      featuredProduct: .init(
        id: 0,
        title: "featuredProduct title",
        price: "featuredProduct price",
        description: "featuredProduct description",
        category: "featuredProduct category",
        imageURL: "https://example.com/image.jpg",
        rate: 4.0,
        rateCount: 4
      ),
      products: [
        .init(
          id: 1,
          title: "product title",
          price: "product price",
          description: "product description",
          category: "product category",
          imageURL: "https://example.com/image.jpg",
          rate: 2.0,
          rateCount: 2
        ),
      ],
      categories: ["featuredProduct category", "product category"]
    )
  }
}
