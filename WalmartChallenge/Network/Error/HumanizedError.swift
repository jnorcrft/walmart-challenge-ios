struct HumanizedError: Decodable {
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
}
