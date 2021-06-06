import UIKit
extension UIImageView {
  func downloadImageFrom(link:String, contentMode: UIView.ContentMode) {
        URLSession.shared.dataTask( with: NSURL(string:link)! as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data {
                  self.image = UIImage(data: data)
                }
            }
        }).resume()
    }
}
