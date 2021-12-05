
import Foundation

public struct Dog: Decodable, Equatable {
    
    let name: String
    let breedGroup: String?
    let temperament: String?
    let origin: String?
    let image: Image?
    let referenceImageId: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case breedGroup = "breed_group"
        case temperament = "temperament"
        case origin = "origin"
        case image = "image"
        // After implementing the requirement #2 I noticed that the returned object query returns a image reference id and not a image so I need to add a new field to this struct
        case referenceImageId = "reference_image_id"
    }
}

struct Image: Decodable, Equatable {
    let url: String
}
