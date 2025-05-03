enum HTTPStatusCode: Int, CaseIterable, Decodable {
  case OK = 200
  case created = 201
  case badRequest = 400
  case unauthorized = 401
  case forbidden = 403
  case notFound = 404
  case methodNotAllowed = 405
  case locked = 423
  case internalServerError = 500
  case badGateway = 502
  case serviceUnavailable = 503
  case unhandled

  static func isSuccess(from statusCode: Int) -> Bool {
    (OK.rawValue ..< badRequest.rawValue).contains(statusCode)
  }
}
