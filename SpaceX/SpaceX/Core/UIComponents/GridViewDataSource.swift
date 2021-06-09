import UIKit
import Apollo
protocol GridItemCallBacK: AnyObject {

}
class GridViewDataSource<Cell: DynamicDataCell, DataType: JSONEncodable>: NSObject, UICollectionViewDataSource where Cell: UICollectionViewCell {
  var dataSource: [JSONEncodable]?
  weak var delegate: GridItemCallBacK?
  var configurator: CellConfigurator<Cell, DataType>!
  init(delegate: GridItemCallBacK) {
    self.delegate = delegate
  }
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return dataSource?.count ?? 5
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: Cell.self), for: indexPath) as? Cell else {
      return UICollectionViewCell()
    }
    if let configItem = dataSource?[indexPath.row] {
      configurator = CellConfigurator<Cell, DataType>(item: configItem, cell: cell)
    }
    return cell
  }
}
