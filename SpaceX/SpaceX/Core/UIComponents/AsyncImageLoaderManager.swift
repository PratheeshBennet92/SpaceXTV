import UIKit
class AsyncImageLoaderManager: NSObject {
    static let sharedInstance = AsyncImageLoaderManager()
    var imageCache:NSCache<NSString, UIImage>
    override init() {
        self.imageCache = NSCache()
    }
    func getImage(forUrl url:String) -> UIImage? {
        return self.imageCache.object(forKey: url as NSString)
    }
    func setImage(image:UIImage,forKey url:String) -> Void {
        self.imageCache.setObject(image, forKey: url as NSString)
    }
}
