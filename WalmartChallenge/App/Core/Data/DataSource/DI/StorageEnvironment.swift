final class StorageEnvironment: Sendable {
  // MARK: - Storage

  func makeLocalStorage() -> StoragePersisting {
    UserDefaultsStorage()
  }
}
