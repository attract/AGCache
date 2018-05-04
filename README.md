# AGCache
AGCache is simple and lightweight library that allows you to download images, resize them on-the-go and save downloaded items to cache. It works fully asynchronous so you’ll never face performance issue.

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

If you need batch images downloading, use another function:
```
AGCache.shared.downloadImage(from: [urlStrings], size: CGSize(width: 100, height: 100)) { (cacheDictionary: [String:UIImage?]) in
            // needed images are saved in dictionary, call them by url
        }
```

Another method allows you to download and resize image without storing it locally:

```
func downloadWithoutSavingToOffline(from urlString: String, size: CGSize, completion: @escaping (_ completion: UIImage?) -> Void)
```

And, of course, if you need to clear cache, you can do it next way:

```
AGCache.shared.clearAll()
```
