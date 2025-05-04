final class ServiceEnvironment: Sendable {
  private let networkEnvironment: NetworkEnvironment

  init(networkEnvironment: NetworkEnvironment) {
    self.networkEnvironment = networkEnvironment
  }

  func makeImageFetchingService() -> some ImageFetching {
    ImageFetchingService(client: networkEnvironment.makeNetworkClient())
  }
}
