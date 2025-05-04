final class NetworkEnvironment: Sendable {
  func makeNetworkClient() -> NetworkRequestable {
    URLSessionClient()
  }
}
