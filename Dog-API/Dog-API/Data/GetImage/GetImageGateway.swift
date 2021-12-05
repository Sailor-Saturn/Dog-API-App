
import Foundation

enum ImageGatewayError: Error {
    case errorGettingData
    case errorParsingData
    case operationFailed
}

protocol ImageGatewayProtocol: AnyObject {
    func getImage(completion: @escaping(Result<Image, ImageGatewayError>) -> Void, image: String)
}

final class ImageGateway: ImageGatewayProtocol {
    
    let networkSession: NetworkSession
    
    init(networkSession: NetworkSession = URLSession.shared) {
        self.networkSession = networkSession
    }
    
    let decoder = JSONDecoder()
    
    func getImage(completion: @escaping(Result<Image, ImageGatewayError>) -> Void, image: String) {
        
        let request = GetImageRequest(with: image)
        
        networkSession.loadData(from: request.urlRequest) { data, _ in
            guard let jsonData =  data else {
                completion(.failure(.errorGettingData))
                return
            }
            
            do {
                let response = try self.decoder.decode(Image.self, from: jsonData)
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
