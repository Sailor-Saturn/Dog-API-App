
import Foundation

enum AllDogsGatewayError: Error {
    case errorGettingData
    case errorParsingData
    case operationFailed
}

protocol AllDogsGatewayProtocol: AnyObject {
    func getAllDogs(completion: @escaping(Result<[Dog], AllDogsGatewayError>) -> Void)
}

final class AllDogsGateway: AllDogsGatewayProtocol {
    
    let networkSession: NetworkSession
    
    init(networkSession: NetworkSession = URLSession.shared) {
        self.networkSession = networkSession
    }
    
    let decoder = JSONDecoder()
    
    func getAllDogs(completion: @escaping (Result<[Dog], AllDogsGatewayError>) -> Void) {
        
        let request = GetAllDogsRequest()
        
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
