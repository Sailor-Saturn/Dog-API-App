import Foundation

class Utils {
    // TODO: Add tests for this function
    static func buildDogInfo(with dog: Dog) -> Dog{
        
        return Dog(name: dog.name,
                   breedGroup: buildField(with: dog.breedGroup),
                   temperament: buildField(with: dog.temperament),
                   origin: buildField(with: dog.origin),
                   image: dog.image,
                   //TODO: Refactor this
                   referenceImageId: "BJa4kxc4X")
        
    }
    
    static func buildField(with field: String?) -> String{
        var returnedField: String
        if (field == nil || field == ""){
            returnedField = InformationConstant.noInformation.rawValue
        }else {
            returnedField = field!
        }
        
        return returnedField
    }
}
