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
      self.missionImage.downloadImageFrom(link: imageUrl, contentMode: .scaleToFill) { data in
        self.activityLoaded.stopAnimating()
        self.activityLoaded.isHidden = true
        imageDownload?(data)
      }
    } else {
      self.activityLoaded.isHidden = false
      activityLoaded.startAnimating()
    }
  }
}
