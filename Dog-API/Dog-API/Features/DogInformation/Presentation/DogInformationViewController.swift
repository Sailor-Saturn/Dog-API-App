
import UIKit

final class DogInformationViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var temperament: UILabel!
    @IBOutlet weak var origin: UILabel!
    @IBOutlet weak var breedGroup: UILabel!
    
    var presenter: DogInformationPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension DogInformationViewController: DogInformationView {
    
    func displayImage(with url: String) {
        // TODO: Add this URL to image to a util class, this is the second time using the exact same instruction
        DispatchQueue.global().async { [weak self] in
            guard let newURL = URL(string: url) else {
                return
            }
            
            guard let imageData = try? Data(contentsOf: newURL) else {
                return
            }
            
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self?.image.image = image
            }
        }
    }
    
    func displayName(with name: String) {
        self.name.text = name
    }
    
    func displayTemperament(with temperament: String) {
        self.temperament.text = temperament
    }
    
    func displayOrigin(with origin: String) {
        self.origin.text = origin
    }
    
    func displayBreedGroup(with group: String) {
        self.breedGroup.text = group
    }
    
}

// TODO: Refactor information to only show the following:
//1.  Breed Name
//2. Breed Category
//3. Origin
//4. Temperament
