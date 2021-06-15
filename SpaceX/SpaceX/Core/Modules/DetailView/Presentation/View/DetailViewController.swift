import UIKit
import Apollo
class DetailViewController: UIViewController {
  var selectedMission: JSONEncodable?
  private var gridViewImages: GridViewController<DetailViewCell,[String]> = {
    let view = GridViewController<DetailViewCell,  [String]>()
    view.view.translatesAutoresizingMaskIntoConstraints  = false
    return view
  }()
  private let scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    return scrollView
  }()
  private var containerView: UIStackView = {
    let stackView = UIStackView()
    //stackView.backgroundColor = .yellow
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    //stackView.distribution = .fillProportionally
    stackView.spacing = UIStackView.spacingUseSystem
    stackView.isLayoutMarginsRelativeArrangement = true
    //stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: -100, leading: 20, bottom: 20, trailing: 20)
    return stackView
  }()
  override func viewDidLoad() {
    super.viewDidLoad()
    addScrollView()
    addContainerView()
    addImageGrid()
    setImageGrid()
    addRocket()
    addLaunchSite()
    addDetails()
  }
  private func setImageGrid() {
    if let images = (selectedMission as? LaunchlistQuery.Data.LaunchesPast)?.links?.flickrImages {
    let viewModel = DetailViewModel(arrImages: images)
    gridViewImages.viewModel = viewModel
    gridViewImages.setupViewModel()
    }
  }
  private func addContainerView() {
    scrollView.addSubview(containerView)
    containerView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: .zero).isActive = true
    //containerView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: .zero).isActive = true
    containerView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: .zero).isActive = true
    containerView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
    containerView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: .zero).isActive = true
  }
  private func addImageGrid() {
    containerView.addArrangedSubview(createLabel(text: (selectedMission as? LaunchlistQuery.Data.LaunchesPast)?.missionName ?? ""))
    gridViewImages.view.translatesAutoresizingMaskIntoConstraints  = false
    self.addChild(gridViewImages)
    gridViewImages.view.heightAnchor.constraint(equalToConstant: 350).isActive = true
    containerView.addArrangedSubview(gridViewImages.view)
    gridViewImages.didMove(toParent: self)
  }
  private func addRocket() {
    let label = createLabel(text: "Rocket: "+((selectedMission as? LaunchlistQuery.Data.LaunchesPast)?.rocket?.rocketName)! ?? "", font: UIFont.systemFont(ofSize: 28.0))
    containerView.addArrangedSubview(label)
  }
  private func addDetails() {
    let label = createLabel(text: (selectedMission as? LaunchlistQuery.Data.LaunchesPast)?.details ?? "", font: UIFont.systemFont(ofSize: 28.0))
    //label.preferredMaxLayoutWidth = self.view.bounds.width;
    containerView.addArrangedSubview(label)
  }
  private func addLaunchSite() {
    let label = createLabel(text: (selectedMission as? LaunchlistQuery.Data.LaunchesPast)?.launchSite?.siteNameLong ?? "", font: UIFont.systemFont(ofSize: 28.0))
    label.preferredMaxLayoutWidth = self.view.bounds.width;
    containerView.addArrangedSubview(label)
  }
  private func addScrollView() {
    view.addSubview(scrollView)
    scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: .zero).isActive = true
    scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: .zero).isActive = true
    scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: .zero).isActive = true
    scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: .zero).isActive = true
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
    return myLabel
  }
}
