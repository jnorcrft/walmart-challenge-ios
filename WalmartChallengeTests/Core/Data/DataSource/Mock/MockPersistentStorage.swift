import Foundation
@testable import WalmartChallenge

final class MockPersistentStorage {
  private(set) var codableStorage: [String: Codable] = [:]

  var shouldThrowError: Bool = false

}

extension MockPersistentStorage: StoragePersisting {
  func save<T>(_ value: T, forKey key: String) throws where T : Decodable, T : Encodable {
    if shouldThrowError {
      throw NSError()
    }
    codableStorage[key] = value
  }
  
  func retrieve<T>(forKey key: String) throws -> T? where T : Decodable, T : Encodable {
    if shouldThrowError {
      throw NSError()
    }
    guard let value = codableStorage[key] as? T else {
      return nil
    }
    return value
  }
  
  func remove(forKey key: String) {
    codableStorage.removeValue(forKey: key)
  }
  
  func removeAll() {
    codableStorage = [:]
  }
  
}
