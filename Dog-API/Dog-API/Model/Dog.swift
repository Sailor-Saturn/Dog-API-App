
import Foundation

public struct Dog: Decodable, Equatable {
    
    let name: String
    let bredFor: String?
    let breedGroup: String?
    let lifeSpan: String?
    let temperament: String?
    let origin: String?
    let image: Image
    let weight: Weight
    let height: Height
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case bredFor = "bred_for"
        case breedGroup = "breed_group"
        case lifeSpan = "life_span"
        case temperament = "temperament"
        case origin = "origin"
        case image = "image"
        // TODO: Change these types so that the units can be chosen via UI.
        case weight = "weight"
        case height = "height"
    }
}

struct Image: Decodable, Equatable {
    let url: String
}

struct Weight: Decodable, Equatable {
    let metric: String
    let imperial: String
}

struct Height: Decodable, Equatable {
    let metric: String
    let imperial: String
}

