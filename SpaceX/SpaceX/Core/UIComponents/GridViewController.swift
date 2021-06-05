import Foundation
import UIKit
import Apollo
class GridViewController<Cell: DynamicDataCell, DataType: JSONEncodable>: UIViewController, UINavigationControllerDelegate, UIScrollViewDelegate where Cell: UICollectionViewCell {
  var viewModel: ViewModelProtocol?
  var dataSource: GridViewDataSource<Cell, DataType>?
  var delegate: GridViewDelegate?
  lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView()
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()
  private func configureCollectionView() {
    delegate = GridViewDelegate(delegate: self)
    dataSource = GridViewDataSource<Cell, DataType>(delegate: self)
    self.collectionView.delegate = delegate
    self.collectionView.dataSource = dataSource
    self.collectionView.contentInsetAdjustmentBehavior = .never
    self.collectionView.register(UINib(nibName: String(describing:  GridViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing:  GridViewCell.self))
    self.collectionView.showsHorizontalScrollIndicator = false
    self.collectionView.showsVerticalScrollIndicator = false
    if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.estimatedItemSize = CGSize(width: 56, height: 56)
    }
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    configureCollectionView()
    addGridView()
  }
  private func addGridView() {
    self.view.addSubview(collectionView)
    collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: .zero).isActive = true
    collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: .zero).isActive = true
    collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: .zero).isActive = true
    collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: .zero).isActive = true
  }
}
extension GridViewController: GridCallBacK {
  func didSelectionOfItem(_ indexPath: IndexPath) {
    
  }
}
extension GridViewController: GridItemCallBacK {
}
