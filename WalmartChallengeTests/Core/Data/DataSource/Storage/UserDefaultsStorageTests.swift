import XCTest

@testable import WalmartChallenge

final class UserDefaultsStorageTests: XCTestCase {
  private var sut: StoragePersisting!
  private var userDefaults: UserDefaults!

  override func setUp() {
    super.setUp()
    userDefaults = UserDefaults(suiteName: #file)
    sut = UserDefaultsStorage(userDefaults: userDefaults)
  }

  override func tearDown() {
    sut.removeAll()
    userDefaults.removePersistentDomain(forName: #file)
    sut = nil
    super.tearDown()
  }

  func test_storage_saveAndReadSucceeds() throws {
    let value: Codable = DummyEncodable(foo: "bar")
    let key = "dummy_key"

    try sut.save(value, forKey: key)

    if let dummyEncodable: DummyEncodable = try sut.retrieve(forKey: key) {
      XCTAssertEqual(dummyEncodable.foo, "bar")
    }

    sut.remove(forKey: key)

    let dummyEncodable: DummyEncodable? = try? sut.retrieve(forKey: key)
    XCTAssertNil(dummyEncodable)
  }
}

extension UserDefaultsStorageTests {
  struct DummyEncodable: Codable {
    let foo: String
  }
}
