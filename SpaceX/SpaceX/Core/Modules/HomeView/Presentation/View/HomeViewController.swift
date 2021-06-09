//
//  HomeViewController.swift
//  SpaceX
//
//  Created by Pratheesh on 6/5/21.
//

import UIKit
import Apollo
class HomeViewController: UIViewController {
  private var gridViewCrew: GridViewController<GridViewCell,  [LaunchlistQuery.Data.LaunchesPast]> = {
    let view = GridViewController<GridViewCell,  [LaunchlistQuery.Data.LaunchesPast]>()
    view.view.translatesAutoresizingMaskIntoConstraints  = false
    return view
  }()
  private var gridViewSatellite: GridViewController<GridViewCell,  [LaunchlistQuery.Data.LaunchesPast]> = {
    let view = GridViewController<GridViewCell,  [LaunchlistQuery.Data.LaunchesPast]>()
    view.view.translatesAutoresizingMaskIntoConstraints  = false
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addCrewGrid()
    addSatelliteGrid()
    setSatellite()
    setCrewdragon()
    // Do any additional setup after loading the view.
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
  private func addCrewGrid() {
    gridViewCrew.view.translatesAutoresizingMaskIntoConstraints  = false
    self.addChild(gridViewCrew)
    self.view.addSubview(gridViewCrew.view)
    gridViewCrew.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: .zero).isActive = true
    gridViewCrew.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: .zero).isActive = true
    gridViewCrew.view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: .zero).isActive = true
    gridViewCrew.view.heightAnchor.constraint(equalToConstant: 350).isActive = true
    //gridViewCrew.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: .zero).isActive = true
    gridViewCrew.didMove(toParent: self)
  }
  private func addSatelliteGrid() {
    gridViewSatellite.view.translatesAutoresizingMaskIntoConstraints  = false
    self.addChild(gridViewSatellite)
    self.view.addSubview(gridViewSatellite.view)
    gridViewSatellite.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: .zero).isActive = true
    gridViewSatellite.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: .zero).isActive = true
    gridViewSatellite.view.topAnchor.constraint(equalTo: gridViewCrew.view.bottomAnchor, constant: 50).isActive = true
    gridViewSatellite.view.heightAnchor.constraint(equalToConstant: 350).isActive = true
    //gridViewCrew.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: .zero).isActive = true
    gridViewSatellite.didMove(toParent: self)
  }
}
