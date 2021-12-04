
import Foundation

@testable import Dog_API

public class MockNetworkSession: NetworkSession {
    public var data: Data?
    public var error: Error?

    public init() {}

    public func loadData(from request: URLRequest, completionHandler: @escaping (Data?, Error?) -> Void) {
        completionHandler(data, error)
    }
}
