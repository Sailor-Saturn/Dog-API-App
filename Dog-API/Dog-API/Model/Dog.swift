
import Foundation

public struct Dog: Decodable, Equatable {
    
    let name: String
    let breedGroup: String?
    let temperament: String?
    let origin: String?
    let image: Image
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case breedGroup = "breed_group"
        case temperament = "temperament"
        case origin = "origin"
        case image = "image"
    }
}

struct Image: Decodable, Equatable {
    let url: String
}
