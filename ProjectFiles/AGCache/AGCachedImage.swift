import Foundation
import UIKit

class AGCachedImage: Codable {
    var path: String?
    var data: Data?
    
    init(path: String) {
        if let encodedData = UserDefaults.standard.data(forKey: path), let object = try? JSONDecoder().decode(AGCachedImage.self, from: encodedData) {
            self.path = object.path
            self.data = object.data
        } else {
            self.path = path
        }
    }
    
    init(path: String, data: Data) {
        self.path = path
        self.data = data

        self.saveImageToCache()
    }
    
    func image(size: CGSize) -> UIImage? {
        if let _ = self.path, let data = self.data {
            self.data = data
            
            return self.resizeImage(to: size)
        }
        
        return nil
    }
    
    func resizeImage(to newSize: CGSize) -> UIImage? {
        if let data = self.data, let image = UIImage(data: data) {
            return image.resized(to: newSize)
        }
        
        return nil
    }
    
    func saveImageToCache() {
        if let path = self.path, let encodedObject = try? JSONEncoder().encode(self) {
            UserDefaults.standard.set(encodedObject, forKey: path)
            
            AGCacheLogger.shared.addCacheItem(with: path)
        }
    }
    
    func removeImageFromCache() {
        if let path = self.path {
            UserDefaults.standard.set(nil, forKey: path)
            
            self.data = nil
            self.path = nil
            
            if AGCacheLogger.shared.itemExists(item: path) {
                AGCacheLogger.shared.removeCacheItem(at: path, photoRemoved: true)
            }
        }
    }
}
