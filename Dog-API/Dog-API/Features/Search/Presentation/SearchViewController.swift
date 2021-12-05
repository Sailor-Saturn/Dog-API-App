
import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.isHidden = true
    }
}

//extension SearchViewController: UICollectionViewController {
//    
//}
