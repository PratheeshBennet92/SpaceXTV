//
//  ViewController.swift
//  SpaceX
//
//  Created by Pratheesh on 6/3/21.
//

import UIKit
import Apollo
class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    Network.shared.apollo.fetch(query: LaunchlistQuery()) { result in
      switch result {
      case .success(let graphQLResult):
        print("Success! Result: \(graphQLResult)")
      case .failure(let error):
        print("Failure! Error: \(error)")
      }
    }
    // Do any additional setup after loading the view.
  }


}

