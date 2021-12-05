
import UIKit

class SearchViewController: UIViewController, UICollectionViewDataSource{
    
    @IBOutlet weak var placeholderView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: SearchPresenter?
    var searchGateway = SearchGateway()
    var imageGateway = ImageGateway()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isHidden = true
        searchTextField.delegate = self
    
        presenter = SearchPresenter(
            searchManager: SearchManager(searchGateway: searchGateway, imageGateway: imageGateway),
            view: self)
    }
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        if let text = searchTextField.text {
            presenter?.searchQuery(with: text)
            placeholderView.isHidden = true
            collectionView.isHidden = false
        }
        searchTextField.text = ""
    }
    
    struct Storyboard {
        static let dogViewCell = "DogSearchCell"
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

// MARK: - UIText Field Delegate
extension SearchViewController: UITextFieldDelegate {
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something..."
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = searchTextField.text {
            presenter?.searchQuery(with: text)
            placeholderView.isHidden = true
            collectionView.isHidden = false
        }
        
        searchTextField.text = ""
    }
}

extension SearchViewController: SearchView {
    
    func reloadData() {
        self.collectionView.reloadData()
    }
    
    func navigateToDogInformationScreen(with dog: Dog) {
        self.performSegue(withIdentifier: Segues.searchScreenToDogInformationScreen, sender: dog)
    }
}

extension SearchViewController: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // TODO: How can I avoid the presenter being guarded everytime I use it?
        guard let presenter = presenter else {
            return 0
        }
        return presenter.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let presenter = presenter else {
            return 0
        }
        
        return presenter.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let presenter = presenter else {
            return UICollectionViewCell()
        }
        
        if let dogCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.dogViewCell, for: indexPath) as? SearchCollectionCell{
            presenter.configureDogCellView(dogCell, forIndex: indexPath.row)
            return dogCell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelect(row: indexPath.row)
    }
}
