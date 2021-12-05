

import Foundation

enum SearchGatewayError: Error {
    case errorGettingData
    case errorParsingData
    case operationFailed
}

protocol SearchGatewayProtocol: AnyObject {
    func search(completion: @escaping(Result<[Dog], SearchGatewayError>) -> Void, query: String)
}

final class SearchGateway: SearchGatewayProtocol {
    
    let networkSession: NetworkSession
    
    init(networkSession: NetworkSession = URLSession.shared) {
        self.networkSession = networkSession
    }
    
    let decoder = JSONDecoder()
    
    func search(completion: @escaping(Result<[Dog], SearchGatewayError>) -> Void, query: String) {
        
        let request = SearchRequest(with: query)
        
        networkSession.loadData(from: request.urlRequest) { data, _ in
            guard let jsonData =  data else {
                completion(.failure(.errorGettingData))
                return
            }
            
            do {
                let response = try self.decoder.decode([Dog].self, from: jsonData)
                // TODO: Add logic for when there is no internet
                completion(.success(response))
            } catch {
                debugPrint(error)
                print(error.localizedDescription)
                completion(.failure(.errorParsingData))
            }
        }
    }
}
