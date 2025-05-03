protocol DataProviding: AnyObject & Sendable {
  associatedtype Endpoint: EndpointProviding

  var domain: DomainURLHelper<Endpoint> { get }
  var client: NetworkRequestable { get }

  init(client: NetworkRequestable)
}
