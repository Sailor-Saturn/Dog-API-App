
import Foundation
enum InformationConstant: String {
    case noInformation = "No information"
}
protocol AllDogsManagerProtocol: AnyObject {
    func requestAllDogs(completion: @escaping(Result<[Dog], AllDogsGatewayError>) -> Void)
}

public class AllDogsManager: AllDogsManagerProtocol {
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
    
    // TODO: Add tests for this function
    func buildDogInfo(with dog: Dog) -> Dog{
        
        return Dog(name: dog.name,
                   breedGroup: buildField(with: dog.breedGroup),
                   temperament: buildField(with: dog.temperament),
                   origin: buildField(with: dog.origin),
                   image: dog.image)
        
    }
    
    func buildField(with field: String?) -> String{
        var returnedField: String
        if (field == nil || field == ""){
            returnedField = InformationConstant.noInformation.rawValue
        }else {
            returnedField = field!
        }
        
        return returnedField
    }
}
