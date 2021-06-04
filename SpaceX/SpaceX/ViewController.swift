//
//  ViewController.swift
//  SpaceX
//
//  Created by Pratheesh on 6/3/21.
//

import UIKit
import Apollo
class ViewController: UIViewController {
  @IBOutlet weak var lbl: UILabel!
  let viewModel = HomeViewModel()
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.response.filter { responseObj in
      responseObj != nil
    }.subscribe(onNext: { [weak self] (responseObj) in
      guard let self = self else {return}
      print(responseObj as? [LaunchlistQuery.Data.LaunchesPast?]?)
      self.lbl.text = "\((responseObj as? [LaunchlistQuery.Data.LaunchesPast?]?)??.count ?? 0) Objects received"
    })
    viewModel.startViewModel()
  }


}

