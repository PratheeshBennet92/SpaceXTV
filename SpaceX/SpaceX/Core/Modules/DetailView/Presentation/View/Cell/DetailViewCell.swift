import UIKit
import Apollo
class DetailViewCell: UICollectionViewCell, DynamicDataCell {
  var buttonPressedAction: ((ImageModel?) -> Void)?
  typealias DataType = ImageModel
  @IBOutlet weak var missionImage: UIImageView!
  @IBOutlet weak var activityLoaded: UIActivityIndicatorView!
  override func prepareForReuse() {
    super.prepareForReuse()
    contentView.transform =  CGAffineTransform(scaleX: 0.90, y: 0.90)
  }
  func configure(_ dataType: ImageModel?, imageDownload: ((Data) -> Void)?) {
    contentView.transform =  CGAffineTransform(scaleX: 0.90, y: 0.90)
    missionImage.image = nil
    missionImage.adjustsImageWhenAncestorFocused = true
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
