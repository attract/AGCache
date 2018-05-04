# AGCache
AGCache is a simple and lightweight library that allows downloading images, resizing them on-the-go and saving the downloaded items to the cache. It works fully asynchronously so you’ll never face performance issues.

## Installation
You need `CocoaPods` to be preinstalled.

Add this line to your `Podfile` into app target section:

```
pod 'AGCache'
```

## Usage
First of all, import AGCache module into your ViewController file (or everywhere you need it):

```
import AGCache
```

To download and store one single image use this function:

```
AGCache.shared.downloadImage(from: urlString, size: CGSize(width: 100, height: 100)) { (image) in
            // use image as you need
        }
```

If you need to download batch images, use another function:
```
AGCache.shared.downloadImages(from: [urlStrings], size: CGSize(width: 100, height: 100)) { (cacheDictionary: [String:UIImage?]) in
            // needed images are saved in dictionary, call them by url
        }
```

Another method allows you to download and resize images without storing them locally:

```
func downloadWithoutSavingToOffline(from urlString: String, size: CGSize, completion: @escaping (_ completion: UIImage?) -> Void)
```

And, of course, if you need to clear the cache, you can do it the following way:

```
AGCache.shared.clearAll()
```
