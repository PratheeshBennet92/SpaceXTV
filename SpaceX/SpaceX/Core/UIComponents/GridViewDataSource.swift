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
    return dataSource?.count ?? .zero
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: Cell.self), for: indexPath) as? Cell else {
      return UICollectionViewCell()
    }
    (cell as? GridViewCell)?.imageView.image = UIImage(named: "placeholder_logo.png")
    (cell as? GridViewCell)?.title.text = ""
    if let configItem = dataSource?[indexPath.row] {
      configurator = CellConfigurator<Cell, DataType>(item: configItem, cell: cell)
      configurator.imageDownloaded = { data in
        (cell as? GridViewCell)?.imageView.image = UIImage(data: data)
        (cell as? DetailViewCell)?.missionImage.image = UIImage(data: data)
      }
    }
    return cell
  }
}
