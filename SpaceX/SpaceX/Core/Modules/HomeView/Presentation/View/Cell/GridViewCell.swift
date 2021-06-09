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
  func configure(_ dataType: LaunchlistQuery.Data.LaunchesPast?) {
    self.title.text = dataType?.missionName
    self.imageView.image = UIImage(named: "placeholder_logo.png")
    if let imageUrl = dataType?.links?.missionPatch {
      self.imageView.downloadImageFrom(link: imageUrl, contentMode: .scaleToFill)
    } else {
      self.imageView.image = UIImage(named: "placeholder_logo.png")
    }
  }
}