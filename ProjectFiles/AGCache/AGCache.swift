import Foundation
import UIKit

public class AGCache {
    public static let shared = AGCache()
    
    public func downloadImages(from urls: [String], size: CGSize, completion: @escaping (_ completion: [String:UIImage?]) -> Void) {
        DispatchQueue.global().async {
            var images: [String:UIImage?] = [:]
            
            for urlString in urls {
                let cachedImage = AGCachedImage(path: urlString)
                
                if let image = cachedImage.image(size: size) {
                    images[urlString] = image
                } else {
                    if let url = URL(string: urlString), let data = try? Data.init(contentsOf: url) {
                        let cImage = AGCachedImage(path: urlString, data: data)
                        
                        if let image = cImage.image(size: size) {
                            images[urlString] = image
                        }
                    } else {
                        images[urlString] = nil
                    }
                }
            }
            
            DispatchQueue.main.async {
                completion(images)
            }
        }
    }
    
    public func downloadImage(from urlString: String, size: CGSize, completion: @escaping (_ completion: UIImage?) -> Void) {
        DispatchQueue.global().async {
            let cachedImage = AGCachedImage(path: urlString)
            
            var resultImage: UIImage? = nil
            
            if let image = cachedImage.image(size: size) {
                resultImage = image
            } else {
                if let url = URL(string: urlString), let data = try? Data.init(contentsOf: url) {
                    
                    let cImage = AGCachedImage(path: urlString, data: data)
                    
                    if let image = cImage.image(size: size) {
                        resultImage = image
                    }
                }
            }
            
            DispatchQueue.main.async {
                completion(resultImage)
            }
        }
    }
    
    public func downloadWithoutSavingToOffline(from urlString: String, size: CGSize, completion: @escaping (_ completion: UIImage?) -> Void) {
        DispatchQueue.global().async {
            var resultImage: UIImage? = nil
            
            if let url = URL(string: urlString), let data = try? Data.init(contentsOf: url) {
                if let image = UIImage(data: data) {
                    resultImage = image.resized(to: size)
                }
            }
            
            DispatchQueue.main.async {
                completion(resultImage)
            }
        }
    }
    
    public func clearAll() {
        AGCacheLogger.shared.removeAll()
    }
}
