import UIKit
class SpinnerController: UIViewController {
  var spinner = UIActivityIndicatorView(style: .large)
  override func loadView() {
    view = UIView()
    view.backgroundColor = UIColor.white
    spinner.translatesAutoresizingMaskIntoConstraints = false
    spinner.startAnimating()
    view.addSubview(spinner)
    spinner.color = UIColor.lightGray
    spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: .zero).isActive = true
  }
}
