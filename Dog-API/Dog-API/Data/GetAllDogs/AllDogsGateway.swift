
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
        
        networkSession.loadData(from: request.urlRequest) {  [weak self] data, _ in
            guard let jsonData =  data else {
                completion(.failure(.errorGettingData))
                return
            }
            
            do {
                guard var response = try self?.decoder.decode([Dog].self, from: jsonData) else {
                    return
                }
                
                // MARK: - Offline Functionality
                if response.isEmpty {
                    
                    response = try self?.decoder.decode([Dog].self, from: getAllDogsRequest.data(using: .utf8)!) as! [Dog]
                }
                
                completion(.success(response))
            } catch {
                debugPrint(error)
                print(error.localizedDescription)
                completion(.failure(.errorParsingData))
            }
        }
    }
}
