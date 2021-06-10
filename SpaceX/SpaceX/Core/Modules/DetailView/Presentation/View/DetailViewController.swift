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
    stackView.distribution = .fillProportionally
    stackView.spacing = UIStackView.spacingUseSystem
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: -100, leading: 20, bottom: 20, trailing: 20)
    return stackView
  }()
  override func viewDidLoad() {
    super.viewDidLoad()
    addContainerView()
    addImageGrid()
    setImageGrid()
    addDetails()
    //addRocket()
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
    containerView.addArrangedSubview(createLabel(text: (selectedMission as? LaunchlistQuery.Data.LaunchesPast)?.missionName ?? ""))
    gridViewImages.view.translatesAutoresizingMaskIntoConstraints  = false
    self.addChild(gridViewImages)
    containerView.addArrangedSubview(gridViewImages.view)
    gridViewImages.didMove(toParent: self)
  }
  private func addRocket() {
    let label = createLabel(text: "Rocket: "+((selectedMission as? LaunchlistQuery.Data.LaunchesPast)?.rocket?.rocketName)! ?? "", font: UIFont.systemFont(ofSize: 28.0))
    containerView.addArrangedSubview(label)
  }
  private func addDetails() {
    let label = createLabel(text: (selectedMission as? LaunchlistQuery.Data.LaunchesPast)?.details ?? "", font: UIFont.systemFont(ofSize: 28.0))
    containerView.addArrangedSubview(label)
  }
  private func createLabel(text: String, font: UIFont = UIFont.boldSystemFont(ofSize: 34.0) ) -> UILabel {
    let myLabel = UILabel()
    myLabel.font = font
    myLabel.translatesAutoresizingMaskIntoConstraints = false
    myLabel.backgroundColor = .clear
    myLabel.text = text
    myLabel.numberOfLines = 0
    myLabel.lineBreakMode = .byWordWrapping
    myLabel.textAlignment = .left
    myLabel.clipsToBounds = true
    myLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    return myLabel
  }
}
