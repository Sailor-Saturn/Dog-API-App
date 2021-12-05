
import Foundation

public protocol DogInformationView {
    func displayImage(with url: String)
    func displayName(with name: String)
    func displayTemperament(with temperament: String)
    func displayOrigin(with origin: String)
    func displayBreedGroup(with group: String)
}
public class DogInformationPresenter {
    let dogInformation: Dog

    public var view: DogInformationView?
    
    init(dogInformation: Dog, view: DogInformationView){
        self.dogInformation = dogInformation
    }
    
    func displayInformation(){
        view?.displayImage(with: dogInformation.image.url)
        view?.displayName(with: "Name: " + dogInformation.name)
        view?.displayTemperament(with: "Temperament: " + dogInformation.temperament!)
        view?.displayOrigin(with: "Origin: " + dogInformation.origin!)
        view?.displayBreedGroup(with: "Breed Category: " + dogInformation.breedGroup!)
        
    }
    
    func viewDidLoad() {
        displayInformation()
    }
}
