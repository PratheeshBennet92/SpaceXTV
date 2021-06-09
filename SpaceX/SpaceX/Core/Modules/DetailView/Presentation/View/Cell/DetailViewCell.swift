import UIKit
import Apollo
class DetailViewCell: UICollectionViewCell, DynamicDataCell {
  var buttonPressedAction: ((ImageModel?) -> Void)?
  typealias DataType = ImageModel
  @IBOutlet weak var missionImage: UIImageView!
  func configure(_ dataType: ImageModel?) {
    if let imageUrl = dataType?.image {
      self.missionImage.downloadImageFrom(link: imageUrl, contentMode: .scaleToFill)
    } else {
      self.missionImage.image = UIImage(named: "placeholder_logo.png")
    }
  }
}
