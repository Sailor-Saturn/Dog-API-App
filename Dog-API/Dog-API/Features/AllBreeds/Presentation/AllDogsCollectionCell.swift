
import UIKit

class AllDogsCollectionCell: UICollectionViewCell, DogCellView {

    @IBOutlet weak var image: UIImageView!
    
    // I didnt know how to show image from URL so I needed to research online and found this
    // https://www.hackingwithswift.com/example-code/uikit/how-to-load-a-remote-image-url-into-uiimageview
    // I still dont understand the dispatch queue behaviour but this
    func displayImage(with url: String) {
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        image.image = nil
    }
}
