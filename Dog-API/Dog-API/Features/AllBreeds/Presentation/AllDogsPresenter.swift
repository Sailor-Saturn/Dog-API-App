
import Foundation

public protocol AllDogsView {
    func reloadData()
}

public class AllDogsPresenter {
    let allDogsManager: AllDogsManager
    public var view: AllDogsView
    
    var allDogs = [Dog]() {
        didSet{
            DispatchQueue.main.async {
                self.view.reloadData()
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
    }
}
