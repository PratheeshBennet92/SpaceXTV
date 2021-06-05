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

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
