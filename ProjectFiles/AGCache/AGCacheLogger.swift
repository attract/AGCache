import Foundation

let cacheLoggerKey = "cacheLogger"

class AGCacheLogger: Codable {
    var paths: [String]?
    
    static let shared = AGCacheLogger()
    
    init() {
        self.paths = []
        
        if let encodedData = UserDefaults.standard.data(forKey: cacheLoggerKey), let object = try? JSONDecoder().decode(AGCacheLogger.self, from: encodedData) {
            self.paths = object.paths
        }
    }
    
    func addCacheItem(with path: String) {
        self.paths?.append(path)
        self.saveLogs()
    }
    
    func removeCacheItem(at path: String, photoRemoved: Bool = false) {
        if let paths = self.paths, let index = paths.index(of: path) {
            self.paths?.remove(at: index)
            self.saveLogs()
        }
        
        if !photoRemoved {
            let cachedItem = AGCachedImage(path: path)
            cachedItem.removeImageFromCache()
        }
    }
    
    func removeAll() {
        if let paths = self.paths {
            for path in paths {
                self.removeCacheItem(at: path, photoRemoved: false)
            }
        }
    }
    
    func saveLogs() {
        if let paths = self.paths, paths.count > 0, let encodedData = try? JSONEncoder().encode(self) {
            UserDefaults.standard.set(encodedData, forKey: cacheLoggerKey)
        }
    }
    
    func itemExists(item path: String) -> Bool {
        if let paths = self.paths {
            return paths.contains(path)
        }
        
        return false
    }
}
