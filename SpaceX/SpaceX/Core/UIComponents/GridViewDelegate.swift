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
    print("Did select tapped", indexPath.row)
    self.delegate?.didSelectionOfItem(indexPath)
  }
  func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {

      if let previousIndexPath = context.previouslyFocusedIndexPath,
         let cell = collectionView.cellForItem(at: previousIndexPath) {
          cell.contentView.layer.borderWidth = 0.0
          cell.contentView.layer.shadowRadius = 0.0
          cell.contentView.layer.shadowOpacity = 0
      }

      if let indexPath = context.nextFocusedIndexPath,
         let cell = collectionView.cellForItem(at: indexPath) {
          cell.contentView.layer.borderWidth = 4.0
        cell.contentView.layer.borderColor = UIColor.black.cgColor
        cell.contentView.layer.shadowColor = UIColor.black.cgColor
          cell.contentView.layer.shadowRadius = 10.0
          cell.contentView.layer.shadowOpacity = 0.9
          cell.contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        collectionView.scrollToItem(at: indexPath, at: [.centeredHorizontally, .centeredVertically], animated: true)
      }
  }

}
