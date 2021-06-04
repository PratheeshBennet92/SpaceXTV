//
//  ViewController.swift
//  SpaceX
//
//  Created by Pratheesh on 6/3/21.
//

import UIKit
import Apollo
class ViewController: UIViewController {
  let viewModel = HomeViewModel()
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.response.filter { each in
      each != nil
    }.subscribe { result in
      print(result)
    }
    viewModel.startViewModel()
  }


}

