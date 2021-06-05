import UIKit
import Apollo
private let reuseIdentifier = "GridViewCell"
class GridViewCell: UICollectionViewCell, DynamicDataCell {
  @IBOutlet weak var title: UILabel!
  var buttonPressedAction: ((LaunchlistQuery.Data.LaunchesPast?) -> Void)?
  typealias DataType = LaunchlistQuery.Data.LaunchesPast
  func configure(_ dataType: LaunchlistQuery.Data.LaunchesPast?) {
    self.title.text = dataType?.missionName
  }
}
