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
    title: "Tu conexión a Internet no responde",
    message: "Para continuar, revisa tu conexión e intentalo de nuevo",
    primaryButtonTitle: "Reintentar",
    presentationStyle: "fullscreen"
  )
}
