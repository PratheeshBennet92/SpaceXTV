import UIKit
import Apollo
import RxSwift
import RxCocoa
class GridViewController<Cell: DynamicDataCell, DataType: JSONEncodable>: UIViewController, UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate where Cell: UICollectionViewCell {
  var viewModel: ViewModelProtocol?
  var dataSource: GridViewDataSource<Cell, DataType>?
  var delegate: GridViewDelegate?
  let disposeBag: DisposeBag = DisposeBag()
  lazy var collectionView: UICollectionView = {
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
    let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()
  private func configureCollectionView() {
    self.collectionView.contentInsetAdjustmentBehavior = .never
    self.collectionView.register(UINib(nibName: String(describing:  GridViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing:  GridViewCell.self))
    self.collectionView.showsHorizontalScrollIndicator = false
    self.collectionView.showsVerticalScrollIndicator = false
    if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.estimatedItemSize = CGSize(width: 300, height: 300)
    }
    delegate = GridViewDelegate(delegate: self)
    dataSource = GridViewDataSource<Cell, DataType>(delegate: self)
    dataSource?.dataSource = viewModel?.outputModel
    self.collectionView.delegate = delegate
    self.collectionView.dataSource = dataSource
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    configureCollectionView()
    addGridView()
  }
  func setupViewModel() {
    viewModel?.startViewModel()
    addObserver()
  }
  private func addGridView() {
    self.view.addSubview(collectionView)
    collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: .zero).isActive = true
    collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: .zero).isActive = true
    collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: .zero).isActive = true
    collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: .zero).isActive = true
  }
  func addObserver() {
    viewModel?.response.subscribe(onNext: { [weak self] (responseObj) in
      guard let self  = self else {return}
      self.dataSource?.dataSource = (responseObj as? [LaunchlistQuery.Data.LaunchesPast?]?) as? [JSONEncodable]
      self.collectionView.reloadData()
    }).disposed(by: disposeBag)
  }
}
extension GridViewController: GridCallBacK {
  func didSelectionOfItem(_ indexPath: IndexPath) {
    
  }
}
extension GridViewController: GridItemCallBacK {
}
