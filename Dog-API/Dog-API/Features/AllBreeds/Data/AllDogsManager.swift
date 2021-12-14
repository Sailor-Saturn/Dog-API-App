
import Foundation
enum InformationConstant: String {
    case noInformation = "No information"
}
protocol AllDogsManagerProtocol: AnyObject {
    func requestAllDogs(completion: @escaping(Result<[Dog], AllDogsGatewayError>) -> Void)
}

public final class AllDogsManager: AllDogsManagerProtocol {
    let allDogsGateway: AllDogsGatewayProtocol
    
    init(allDogsGateway: AllDogsGatewayProtocol){
        self.allDogsGateway = allDogsGateway
    }
    
    func requestAllDogs(completion: @escaping(Result<[Dog], AllDogsGatewayError>) -> Void) {
        allDogsGateway.getAllDogs { result in
            switch result {
            case .failure(let error):
                print("Error in Manager \(error)")
                completion(.failure(.errorGettingData))
            case .success(let dogs):
                completion(.success(dogs))
            }
        }
    }
}
