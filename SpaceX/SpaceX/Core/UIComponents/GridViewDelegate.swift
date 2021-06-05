import UIKit
import Apollo
protocol GridCallBacK: AnyObject {
  func didSelectionOfItem(_ indexPath: IndexPath)
}
class GridViewDelegate: NSObject, UICollectionViewDelegate {
  weak var delegate: GridCallBacK?
  init(delegate: GridCallBacK) {
    self.delegate = delegate
  }
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    self.delegate?.didSelectionOfItem(indexPath)
  }
}
