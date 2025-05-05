import Foundation

struct LandingProductModel: Sendable {
  let id: Int
  let title: String
  let price: String
  let description: String
  let category: String
  let imageURL: String
  let rate: Double
  let rateCount: Int

  var imageData: Data?

  var score: Double {
    rate * Double(rateCount)
  }
}
