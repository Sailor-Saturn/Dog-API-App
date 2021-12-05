
import Foundation

struct GetImageRequest: URLRequestable {
    let url: URL
    
    init(with imageId: String) {
        let urlString = "https://api.thedogapi.com/v1/images/\(imageId)"
        guard let url = URL(string: urlString) else { fatalError() }
        self.url = url
    }
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}
