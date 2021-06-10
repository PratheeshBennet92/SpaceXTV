import UIKit
import Apollo
class DetailViewCell: UICollectionViewCell, DynamicDataCell {
  var buttonPressedAction: ((ImageModel?) -> Void)?
  typealias DataType = ImageModel
  @IBOutlet weak var missionImage: UIImageView!
  @IBOutlet weak var activityLoaded: UIActivityIndicatorView!
  func configure(_ dataType: ImageModel?, imageDownload: ((Data) -> Void)?) {
    missionImage.image = nil
    if let imageUrl = dataType?.image {
      self.missionImage.setImage(url: imageUrl, completion: {
        self.activityLoaded.stopAnimating()
        self.activityLoaded.isHidden = true
      }) 
    } else {
      self.activityLoaded.isHidden = false
      activityLoaded.startAnimating()
    }
  }
}
