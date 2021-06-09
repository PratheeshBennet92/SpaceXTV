import UIKit
import Apollo
class DetailViewController: UIViewController {
  var selectedMission: JSONEncodable?
  private var gridViewImages: GridViewController<DetailViewCell,[String]> = {
    let view = GridViewController<DetailViewCell,  [String]>()
    view.view.translatesAutoresizingMaskIntoConstraints  = false
    return view
  }()
  private var containerView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = UIStackView.spacingUseSystem
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
    return stackView
  }()
  override func viewDidLoad() {
    super.viewDidLoad()
    addContainerView()
    addImageGrid()
    setImageGrid()
  }
  private func setImageGrid() {
    if let images = (selectedMission as? LaunchlistQuery.Data.LaunchesPast)?.links?.flickrImages {
    let viewModel = DetailViewModel(arrImages: images)
    gridViewImages.viewModel = viewModel
    gridViewImages.setupViewModel()
    }
  }
  private func addContainerView() {
    self.view.addSubview(containerView)
    containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: .zero).isActive = true
    containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 90).isActive = true
    containerView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: .zero).isActive = true
    containerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: .zero).isActive = true
  }
  private func addImageGrid() {
    containerView.addArrangedSubview(createLabel(text: "Mission Gallery"))
    gridViewImages.view.translatesAutoresizingMaskIntoConstraints  = false
    self.addChild(gridViewImages)
    containerView.addArrangedSubview(gridViewImages.view)
    gridViewImages.didMove(toParent: self)
  }
  private func createLabel(text: String) -> UILabel {
    let myLabel = UILabel()
    myLabel.translatesAutoresizingMaskIntoConstraints = false
    myLabel.backgroundColor = .clear
    myLabel.text = text
    myLabel.textAlignment = .left
    myLabel.clipsToBounds = true
    myLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    return myLabel
  }
}
