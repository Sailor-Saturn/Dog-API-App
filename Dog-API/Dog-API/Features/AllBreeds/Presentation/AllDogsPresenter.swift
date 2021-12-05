
import Foundation

public protocol AllDogsView {
    func reloadData()
    func navigateToDogInformationScreen(with: Dog)
}

public class AllDogsPresenter {
    let allDogsManager: AllDogsManager
    public var view: AllDogsView?
    
    var allDogs = [Dog]() {
        didSet{
            DispatchQueue.main.async {
                self.view?.reloadData()
            }
        }
    }
    
    init(allDogsManager: AllDogsManager, view: AllDogsView){
        self.allDogsManager = allDogsManager
        self.view = view
    }
    
    func requestAllDogs() {
        allDogsManager.requestAllDogs { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let dogs):
                self?.allDogs = dogs
            }
        }
    }
    
    func numberOfSections() -> Int{
        return 1
    }
    
    func numberOfItems() -> Int {
        return allDogs.count
    }
    
    func configureDogCellView(_ view: DogCellView, forIndex index: Int) {
        let dog = allDogs[index]
        view.displayImage(with: dog.image.url)
        view.displayDogName(with: dog.name)
    }
    
    func didSelect(row: Int){
        let selectedDog = allDogs[row]
        
        //In this case, there are many fields that can be empty in this case they will return a nil
        // object. To show all the information for every dog I'm going to use the manager to return
        // a object with all of the information.
        let dogWithCompleteInfo = allDogsManager.buildDogInfo(with: selectedDog)
        view?.navigateToDogInformationScreen(with: dogWithCompleteInfo)
    }
}
