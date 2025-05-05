import Foundation

struct UserDefaultsStorage: StoragePersisting {
  private let userDefaults: UserDefaults
  private let codableHelper: CodableHelper

  init(
    userDefaults: UserDefaults = .standard,
    codableHelper: CodableHelper = .init()
  ) {
    self.userDefaults = userDefaults
    self.codableHelper = codableHelper
  }

  func save<T>(_ value: T, forKey key: String) throws where T : Encodable {
    if let encodedData = try? codableHelper.encodeObject(object: value) {
      userDefaults.set(encodedData, forKey: key)
    }
  }

  func retrieve<T>(forKey key: String) throws -> T? where T : Decodable {
    if let data: Data = userDefaults.data(forKey: key) {
      return try codableHelper.decodeNetworkObject(from: data)
    } else {
      return nil
    }
  }

  func remove(forKey key: String) {
    userDefaults.removeObject(forKey: key)
  }

  func removeAll() {
    if let bundleID = Bundle.main.bundleIdentifier {
      userDefaults.removePersistentDomain(forName: bundleID)
    }
  }
}
