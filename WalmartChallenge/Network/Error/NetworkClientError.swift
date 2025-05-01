enum NetworkClientError: Error {
  case server(ServerError)
  case client(Error)
  case invalidURL(String)
}
