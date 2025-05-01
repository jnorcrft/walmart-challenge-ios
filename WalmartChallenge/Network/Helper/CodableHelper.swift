import Foundation

struct CodableHelper {
  // MARK: - Properties

  private let decoder: JSONDecoder
  private let encoder: JSONEncoder

  init(
    decoder: JSONDecoder = .init(),
    encoder: JSONEncoder = .init()
  ) {
    self.decoder = decoder
    self.encoder = encoder
  }

  // MARK: - Public Methods

  func decodeNetworkObject<D: Decodable>(from data: Data) throws -> D {
    let decodedObject = try decoder.decode(D.self, from: data)
    return decodedObject
  }

  func encodeObject<E: Encodable>(object: E) throws -> Data {
    let encodedObject = try encoder.encode(object.self)
    return encodedObject
  }
}
