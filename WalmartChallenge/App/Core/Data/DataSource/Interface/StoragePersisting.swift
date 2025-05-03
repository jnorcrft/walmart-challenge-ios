protocol StoragePersisting {
  func save<T: Codable>(_ value: T, forKey key: String) throws
  func retrieve<T: Codable>(forKey key: String) throws -> T?
  func remove(forKey key: String)
  func removeAll()
}
