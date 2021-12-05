
import UIKit

class AllDogsCollectionViewController: UICollectionViewController  {
    var presenter: AllDogsPresenter?
    var gateway = AllDogsGateway()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = AllDogsPresenter(
            allDogsManager: AllDogsManager(allDogsGateway: gateway),
            view: self)
        presenter?.requestAllDogs()
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // TODO: How can I avoid the presenter being guarded everytime I use it?
        guard let presenter = presenter else {
            return 0
        }
        return presenter.numberOfSections()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let presenter = presenter else {
            return 0
        }
        
        return presenter.numberOfItems()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let presenter = presenter else {
            return UICollectionViewCell()
        }
        
        if let dogCell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.dogViewCell, for: indexPath) as? AllDogsCollectionCell{
            presenter.configureDogCellView(dogCell, forIndex: indexPath.row)
            return dogCell
        }
        
        return UICollectionViewCell()
    }
    
    struct Storyboard {
        static let dogViewCell = "DogViewCell"
    }
    
    // MARK: - Collection select
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelect(row: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let dogInformationViewController = segue.destination as? DogInformationViewController,
              let dog = sender as? Dog else {
            return
        }
        
        dogInformationViewController.presenter = DogInformationPresenter(dogInformation: dog, view: dogInformationViewController)
        dogInformationViewController.presenter?.view = dogInformationViewController
    }
}

extension AllDogsCollectionViewController: AllDogsView {

    func reloadData() {
        collectionView.reloadData()
    }
    
    func navigateToDogInformationScreen(with dog: Dog) {
        self.performSegue(withIdentifier: Segues.allDogsScreenToDogInformationScreen, sender: dog)
    }
    
}
