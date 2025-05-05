@MainActor
protocol CartItemViewDelegate: AnyObject {
  func didTapButton(_ type: CartItemButtonType, at index: Int)
}

enum CartItemButtonType {
  case remove
  case increment
  case decrement
}
