import Foundation

struct CodableHelper {
  // MARK: - Properties

  private let decoder: JSONDecoder

  init(decoder: JSONDecoder = JSONDecoder()) {
    self.decoder = decoder
  }

  // MARK: - Public Methods

  func decodeNetworkObject<D: Decodable>(from data: Data) throws -> D {
    let decodedObject = try decoder.decode(D.self, from: data)
    return decodedObject
  }
}
