import Foundation

struct ProductDTO: Decodable & Sendable, Identifiable {
  let id: Int
  let title: String
  let price: Decimal
  let description: String
  let category: String
  let imageURL: String
  let rating: ProductRatingDTO

  private enum CodingKeys: String, CodingKey {
    case id, title, price, description, category
    case imageURL = "image"
    case rating
  }

  struct ProductRatingDTO: Decodable & Sendable {
    let rate: Double
    let count: Int
  }
}
