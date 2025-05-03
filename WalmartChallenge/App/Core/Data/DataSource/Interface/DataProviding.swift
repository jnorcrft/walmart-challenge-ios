protocol DataProviding: AnyObject & Sendable {
  associatedtype Endpoint: Sendable

  var domain: DomainURLHelper<Endpoint> { get }
  var client: NetworkRequestable { get }

  init(client: NetworkRequestable)
}
