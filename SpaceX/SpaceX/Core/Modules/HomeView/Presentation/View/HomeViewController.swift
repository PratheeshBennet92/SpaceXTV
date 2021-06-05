//
//  HomeViewController.swift
//  SpaceX
//
//  Created by Pratheesh on 6/5/21.
//

import UIKit
import Apollo
class HomeViewController: UIViewController {
  private var gridView: GridViewController<GridViewCell,  [LaunchlistQuery.Data.LaunchesPast]> = {
    let view = GridViewController<GridViewCell,  [LaunchlistQuery.Data.LaunchesPast]>()
    view.view.translatesAutoresizingMaskIntoConstraints  = false
    return view
  }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addGrid()
      let viewModel = HomeViewModel()
      gridView.viewModel = viewModel
      gridView.setupViewModel()
        // Do any additional setup after loading the view.
    }
  private func addGrid() {
    gridView.view.translatesAutoresizingMaskIntoConstraints  = false
    self.addChild(gridView)
    self.view.addSubview(gridView.view)
    gridView.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: .zero).isActive = true
    gridView.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: .zero).isActive = true
    gridView.view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: .zero).isActive = true
    gridView.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: .zero).isActive = true
    gridView.didMove(toParent: self)
  }
}
