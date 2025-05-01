struct ServerError: Decodable {
  let httpStatusCode: Int
  let message: String
  let humanizedError: HumanizedError?

  private enum CodingKeys: String, CodingKey {
    case httpStatusCode = "status"
    case message
    case humanizedError = "humanized_error"
  }

  static let placeholder: Self = .init(
    httpStatusCode: HTTPStatusCode.badRequest.rawValue,
    message: "Bad Request",
    humanizedError: .init(
      title: "Tu conexión a Internet no responde",
      message: "Para continuar, revisa tu conexión e intentalo de nuevo",
      primaryButtonTitle: "Reintentar",
      presentationStyle: "fullscreen"
    )
  )
}
