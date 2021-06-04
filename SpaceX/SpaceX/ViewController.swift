//
//  ViewController.swift
//  SpaceX
//
//  Created by Pratheesh on 6/3/21.
//

import UIKit
import Apollo
class ViewController: UIViewController {
  let useCase = HomeUseCase()
  override func viewDidLoad() {
    super.viewDidLoad()
    useCase.response.filter { each in
      each != nil
    }.subscribe { result in
      print(result)
    }
    useCase.executeUseCase()
  }


}

