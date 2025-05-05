@MainActor
protocol CartCountUpdatingDelegate: AnyObject {
  func updateCartCount(_ count: Int)
}
