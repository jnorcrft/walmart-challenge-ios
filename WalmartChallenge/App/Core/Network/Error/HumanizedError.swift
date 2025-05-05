struct HumanizedError: Error & Decodable, Sendable {
  let title: String
  let message: String
  let primaryButtonTitle: String
  let presentationStyle: String

  private enum CodingKeys: String, CodingKey {
    case title
    case message
    case primaryButtonTitle = "button_label"
    case presentationStyle = "component"
  }

  static let placeholder: Self = .init(
    title: "Your Internet connection is not responding",
    message: "To continue, check your connection and try again",
    primaryButtonTitle: "Retry",
    presentationStyle: "fullscreen"
  )
}
