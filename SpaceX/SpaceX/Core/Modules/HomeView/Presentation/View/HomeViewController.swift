import UIKit
import Apollo
class HomeViewController: UIViewController {
  private var gridViewCrew: GridViewController<GridViewCell,  [LaunchlistQuery.Data.LaunchesPast]> = {
    let view = GridViewController<GridViewCell,  [LaunchlistQuery.Data.LaunchesPast]>()
    view.view.translatesAutoresizingMaskIntoConstraints  = false
    return view
  }()
  private var gridViewCargoDragon: GridViewController<GridViewCell,  [LaunchlistQuery.Data.LaunchesPast]> = {
    let view = GridViewController<GridViewCell,  [LaunchlistQuery.Data.LaunchesPast]>()
    view.view.translatesAutoresizingMaskIntoConstraints  = false
    return view
  }()
  private var gridViewSatellite: GridViewController<GridViewCell,  [LaunchlistQuery.Data.LaunchesPast]> = {
    let view = GridViewController<GridViewCell,  [LaunchlistQuery.Data.LaunchesPast]>()
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
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.distribution = .fillProportionally
    stackView.spacing = UIStackView.spacingUseSystem
    stackView.isLayoutMarginsRelativeArrangement = true
    //stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 40, leading: 20, bottom: 20, trailing: 20)
    return stackView
  }()
  override func viewDidLoad() {
    super.viewDidLoad()
    addScrollView()
    addContainerView()
    addCrewGrid()
    addSatelliteGrid()
    addCargoGrid()
    setSatellite()
    setCrewdragon()
    setCargo()
    // Do any additional setup after loading the view.
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  private func setCrewdragon() {
    let viewModel = HomeViewModel()
    viewModel.payloadType = .CrewDragon
    gridViewCrew.viewModel = viewModel
    gridViewCrew.setupViewModel()
  }
  private func setSatellite() {
    let viewModel = HomeViewModel()
    viewModel.payloadType = .Satellite
    gridViewSatellite.viewModel = viewModel
    gridViewSatellite.setupViewModel()
  }
  private func setCargo() {
    let viewModel = HomeViewModel()
    viewModel.payloadType = .CargoDragon
    gridViewCargoDragon.viewModel = viewModel
    gridViewCargoDragon.setupViewModel()
  }
  private func addCrewGrid() {
    containerView.addArrangedSubview(createLabel(text: PayloadType.CrewDragon.rawValue))
    gridViewCrew.view.translatesAutoresizingMaskIntoConstraints  = false
    self.addChild(gridViewCrew)
    gridViewCrew.view.heightAnchor.constraint(equalToConstant: 350).isActive = true
    containerView.addArrangedSubview(gridViewCrew.view)
    gridViewCrew.didMove(toParent: self)
    gridViewCrew.selectionCallBack = { [weak self] response in
      guard let self = self else {
        return
      }
      let detailView = DetailViewController()
      detailView.selectedMission = response
      self.navigationController?.pushViewController(detailView, animated: true)
    }
  }
  private func addSatelliteGrid() {
    containerView.addArrangedSubview(createLabel(text: PayloadType.Satellite.rawValue))
    gridViewSatellite.view.translatesAutoresizingMaskIntoConstraints  = false
    self.addChild(gridViewSatellite)
    gridViewSatellite.view.heightAnchor.constraint(equalToConstant: 350).isActive = true
    containerView.addArrangedSubview(gridViewSatellite.view)
    gridViewSatellite.didMove(toParent: self)
    gridViewSatellite.selectionCallBack = { [weak self] response in
      guard let self = self else {
        return
      }
      let detailView = DetailViewController()
      detailView.selectedMission = response
      self.navigationController?.pushViewController(detailView, animated: true)
    }
  }
  private func addCargoGrid() {
    containerView.addArrangedSubview(createLabel(text: "Cargo Dragon"))
    gridViewCargoDragon.view.translatesAutoresizingMaskIntoConstraints  = false
    self.addChild(gridViewCargoDragon)
    gridViewCargoDragon.view.heightAnchor.constraint(equalToConstant: 350).isActive = true
    containerView.addArrangedSubview(gridViewCargoDragon.view)
    gridViewCargoDragon.didMove(toParent: self)
    gridViewCargoDragon.selectionCallBack = { [weak self] response in
      guard let self = self else {
        return
      }
      let detailView = DetailViewController()
      detailView.selectedMission = response
      self.navigationController?.pushViewController(detailView, animated: true)
    }
  }
  private func addContainerView() {
    scrollView.addSubview(containerView)
    containerView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: .zero).isActive = true
    //containerView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: .zero).isActive = true
    containerView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 50).isActive = true
    containerView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
    containerView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: .zero).isActive = true
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
    myLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    return myLabel
  }
  func showActivityIndicatory() -> UIActivityIndicatorView {
    let activityView = UIActivityIndicatorView(style: .large)
    activityView.center = self.view.center
    self.view.addSubview(activityView)
    activityView.startAnimating()
    return activityView
  }
}
