import UIKit
import Apollo
private let reuseIdentifier = "GridViewCell"
class GridViewCell: UICollectionViewCell, DynamicDataCell {
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var title: UILabel!
  var buttonPressedAction: ((LaunchlistQuery.Data.LaunchesPast?) -> Void)?
  typealias DataType = LaunchlistQuery.Data.LaunchesPast
  override func layoutSubviews() {
      super.layoutSubviews()

      contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
  }
  func configure(_ dataType: LaunchlistQuery.Data.LaunchesPast?, imageDownload: ((Data) -> Void)?) {
    self.title.text = dataType?.missionName
    imageView.image = nil
    self.imageView.image = UIImage(named: "placeholder_logo.png")
    if let imageUrl = dataType?.links?.missionPatch {
      self.imageView.setImage(url: imageUrl) {
        
      }
    } else {
      self.imageView.image = UIImage(named: "placeholder_logo.png")
    }
  }
}
