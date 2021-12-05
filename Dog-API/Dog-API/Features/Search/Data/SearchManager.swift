
import Foundation

protocol SearchManagerProtocol: AnyObject {
    func searchQuery(completion: @escaping(Result<[Dog], SearchGatewayError>) -> Void, query: String)
}

public class SearchManager: SearchManagerProtocol {
    let searchGateway: SearchGatewayProtocol
    let imageGateway: ImageGatewayProtocol
    
    init(searchGateway: SearchGatewayProtocol, imageGateway: ImageGatewayProtocol){
        self.searchGateway = searchGateway
        self.imageGateway = imageGateway
    }
    
    func searchQuery(completion: @escaping(Result<[Dog], SearchGatewayError>) -> Void, query: String) {
        
        searchGateway.search(completion: { result in
            switch result {
            case .failure(let error):
                print("Error in Manager \(error)")
                completion(.failure(.errorGettingData))
            case .success(let dogs):
                completion(.success(dogs))
            }
        },query: query)
    }
    
    func getImage(completion: @escaping(Result<Image, ImageGatewayError>) -> Void, image: String) {
        imageGateway.getImage(completion: { result in
            switch result {
            case .failure(let error):
                print("Error in Manager \(error)")
                completion(.failure(.errorGettingData))
            case .success(let imageURL):
                completion(.success(imageURL))
            }
        }, image: image)
    }
}
