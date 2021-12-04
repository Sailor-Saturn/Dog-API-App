import Foundation

public protocol NetworkSession {
    func loadData(from request: URLRequest, completionHandler: @escaping (Data?, Error?) -> Void)
}

extension URLSession: NetworkSession {
    public func loadData(from request: URLRequest, completionHandler: @escaping (Data?, Error?) -> Void) {
        let task = dataTask(with: request) { (data, response, error) in
            completionHandler(data, error)
        }

        task.resume()
    }
}

