import UIKit
import Apollo
class CellConfigurator<CellType: DynamicDataCell, DataType: JSONEncodable> where CellType: UICollectionViewCell  {
  // MARK: Property Declrations
  var item: JSONEncodable?
  var cell: CellType?
  // MARK: Methods
  init(item: JSONEncodable, cell: CellType) {
    self.item = item
    self.cell = cell
    configure()
  }
  func configure() {
    cell?.configure(item as? CellType.DataType)
  }
}
