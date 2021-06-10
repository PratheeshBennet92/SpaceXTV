import UIKit
extension UIImageView {
  private static var urlStore = [String:String]()
  func setImage(url: String, placeholderImage: UIImage? = UIImage(named: "placeholder_logo"), completion: (() -> Void)?) {
    /*Unique to each instance*/
    let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
    UIImageView.urlStore[tmpAddress] = url
    
    if let image = placeholderImage {
      self.image = image
    } else{
      self.backgroundColor = .gray
    }
    AsyncImageLoader().downloadAndCacheImage(url: url, onSuccess: { (image, url) in
      DispatchQueue.main.async {
        if UIImageView.urlStore[tmpAddress] == url {
          self.image = image
          self.backgroundColor = .clear
          completion?()
        }
      }
    }) { error in
    }
  }
}
