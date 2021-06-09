import UIKit
import Apollo
import RxSwift
import RxCocoa
import AVFoundation
import AVKit
import XCDYouTubeKit
class GridViewController<Cell: DynamicDataCell, DataType: JSONEncodable>: UIViewController, UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate where Cell: UICollectionViewCell {
  var selectionCallBack: ((JSONEncodable?) -> Void)?
  var viewModel: ViewModelProtocol?
  var dataSource: GridViewDataSource<Cell, DataType>?
  var delegate: GridViewDelegate?
  let disposeBag: DisposeBag = DisposeBag()
  private var spinner = SpinnerController()
  lazy var collectionView: UICollectionView = {
    //let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    //layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
    //layout.itemSize = CGSize(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.height/3)
            layout.minimumInteritemSpacing = 20
            layout.minimumLineSpacing = 20
            //collectionView!.collectionViewLayout = layout
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.contentInsetAdjustmentBehavior = .never
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()
  private func configureCollectionView() {
    self.collectionView.contentInsetAdjustmentBehavior = .never
    self.collectionView.register(UINib(nibName: String(describing: HeaderView.self), bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier:String(describing: HeaderView.self))
    self.collectionView.register(UINib(nibName: String(describing:  GridViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing:  GridViewCell.self))
    self.collectionView.register(UINib(nibName: String(describing:  DetailViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing:  DetailViewCell.self))
    self.collectionView.showsHorizontalScrollIndicator = false
    self.collectionView.showsVerticalScrollIndicator = false
    if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 600, height: 300)
        //flowLayout.itemSize = UICollectionViewFlowLayout.automaticSize
        //flowLayout.estimatedItemSize = CGSize(width: 600, height: 300)
    }
    delegate = GridViewDelegate(delegate: self)
    dataSource = GridViewDataSource<Cell, DataType>(delegate: self)
    dataSource?.dataSource = viewModel?.outputModel
    self.collectionView.delegate = delegate
    self.collectionView.dataSource = dataSource
   
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    configureCollectionView()
    addGridView()
    //startSpinner()
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
    collectionView.heightAnchor.constraint(equalToConstant: 350).isActive = true
    //collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: .zero).isActive = true
  }
  func addObserver() {
    viewModel?.response.subscribe(onNext: { [weak self] (responseObj) in
      guard let self  = self else {return}
      //self.stopSpinner()
      self.dataSource?.dataSource = responseObj as? [JSONEncodable]
      self.collectionView.reloadData()
    }).disposed(by: disposeBag)
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 600, height: 300)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
         return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
      }
  // MARK: Spinner configuration
  func stopSpinner() {
    spinner.willMove(toParent: nil)
    spinner.view.removeFromSuperview()
    spinner.removeFromParent()
  }
  func startSpinner() {
    spinner = SpinnerController()
    addChild(spinner)
    spinner.view.frame = view.frame
    view.addSubview(spinner.view)
    spinner.didMove(toParent: self)
  }
}
extension GridViewController: GridCallBacK {
  func didSelectionOfItem(_ indexPath: IndexPath) {
    print("Item selected")
    selectionCallBack?(self.dataSource?.dataSource?[indexPath.row])
    
    guard let path = Bundle.main.path(forResource: "Crew Dragon _ Animation", ofType:"mp4") else {
               debugPrint("video.m4v not found")
               return
           }
           let player = AVPlayer(url: URL(fileURLWithPath: path))
           let playerController = AVPlayerViewController()
           playerController.player = player
//           present(playerController, animated: true) {
//               player.play()
//           }
  }
}
      
extension GridViewController: GridItemCallBacK {
}
