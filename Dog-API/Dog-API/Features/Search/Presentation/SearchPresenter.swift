
import Foundation
public protocol SearchView {
    func reloadData()
    func navigateToDogInformationScreen(with: Dog)
    func displayEmptyView()
    func displayNoInternet()
}

public final class SearchPresenter {
    let searchManager: SearchManager
    public var view: SearchView?
    
    var dogResult = [Dog]() {
        didSet{
            DispatchQueue.main.async {
                self.view?.reloadData()
            }
        }
    }
    
    var returnedDogs = [Dog]() {
        didSet{
            DispatchQueue.main.async {
                self.assignNewArray()
            }
        }
    }
    
    init(searchManager: SearchManager, view: SearchView){
        self.searchManager = searchManager
        self.view = view
    }
    
    func searchQuery(with query: String) {
        // clear list 
        returnedDogs = []
        searchManager.searchQuery(completion: { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                if(error == .errorGettingData) {
                    DispatchQueue.main.async {
                        self?.view?.displayNoInternet()
                    }
                }
            case .success(let dogs):
                // Router.show empty view
                // Gets all object, now it's necessary to build an object with image´
                // MARK: - Error Handling - Empty result list
                if(dogs.isEmpty){
                    DispatchQueue.main.async {
                        self?.view?.displayEmptyView()
                    }
                }else {
                    self?.getDogsWithImages(with: dogs)
                }
                
                //view.removePlaceholder
            }
        }, query: query)
    }
    
    func getDogsWithImages(with dogs: [Dog]) {
        var referenceImage: String
        var dogImage: Image?
        for dog in dogs {
            if (dog.referenceImageId == nil){
                referenceImage = "BJa4kxc4X" //"https://commons.wikimedia.org/wiki/File:No-image-available.png"
                dogImage = Image(url: "https://www.freeiconspng.com/uploads/no-image-icon-15.png")
                
                let newDog =  Dog(name: dog.name,
                                  breedGroup: dog.breedGroup,
                                  temperament: dog.temperament,
                                  origin: dog.origin,
                                  image: dogImage,
                                  referenceImageId: dog.referenceImageId)
                self.returnedDogs.append(newDog)
            } else {
                referenceImage = dog.referenceImageId!
                searchManager.getImage(completion: {  [weak self] result in
                    switch result {
                    case .failure(let error):
                        print("Error in Manager \(error)")
                    case .success(let imageUrl):
                        let newDog =  Dog(name: dog.name,
                                          breedGroup: dog.breedGroup,
                                          temperament: dog.temperament,
                                          origin: dog.origin,
                                          image: imageUrl,
                                          referenceImageId: dog.referenceImageId)
                        self?.returnedDogs.append(newDog)
                    }
                }, image: referenceImage)
            }
            assignNewArray()
            
        }
    }
    
    func assignNewArray() {
        self.dogResult = self.returnedDogs
    }
    
    func numberOfSections() -> Int{
        return 1
    }
    
    func numberOfItems() -> Int {
        return dogResult.count
    }
    
    func configureDogCellView(_ view: DogCellView, forIndex index: Int) {
        let dog = dogResult[index]
        
        guard let image = dog.image else {
            return
        }
        view.displayImage(with: image.url)
        view.displayDogName(with: dog.name)
    }
    
    func didSelect(row: Int){
        let selectedDog = dogResult[row]
        
        //In this case, there are many fields that can be empty in this case they will return a nil
        // object. To show all the information for every dog I'm going to use the manager to return
        // a object with all of the information.
        let dogWithCompleteInfo = Utils.buildDogInfo(with: selectedDog)
        view?.navigateToDogInformationScreen(with: dogWithCompleteInfo)
    }
}
