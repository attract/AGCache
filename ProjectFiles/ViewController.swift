import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var imagePaths: [String] = [
        "https://images.pexels.com/photos/39811/pexels-photo-39811.jpeg",
        "https://images.pexels.com/photos/459225/pexels-photo-459225.jpeg",
        "https://buddhisteconomics.net/wp-content/uploads/2017/10/hdwp693968124.jpg",
        "https://hdwallsource.com/img/2014/5/nature-wallpaper-26203-26893-hd-wallpapers.jpg",
        "https://i.imgur.com/QztlVTN.jpg",
        "http://yodobi.com/4k-Wallpapers/4k-nature-wallpapers-hd-resolution-Is-4K-Wallpaper.jpg",
        "https://wallpapertag.com/wallpaper/full/c/c/b/143196-nature-background-hd-2304x1440-notebook.jpg",
        "http://yodobi.com/4k-Wallpapers/4k-nature-wallpapers-widescreen-Is-4K-Wallpaper.jpg",
        "https://images.pexels.com/photos/39811/pexels-photo-39811.jpeg?000",
        "https://images.pexels.com/photos/459225/pexels-photo-459225.jpeg?000",
        "https://buddhisteconomics.net/wp-content/uploads/2017/10/hdwp693968124.jpg?000",
        "https://hdwallsource.com/img/2014/5/nature-wallpaper-26203-26893-hd-wallpapers.jpg?000",
        "https://i.imgur.com/QztlVTN.jpg?000",
        "http://yodobi.com/4k-Wallpapers/4k-nature-wallpapers-hd-resolution-Is-4K-Wallpaper.jpg?000",
        "https://wallpapertag.com/wallpaper/full/c/c/b/143196-nature-background-hd-2304x1440-notebook.jpg?000",
        "http://yodobi.com/4k-Wallpapers/4k-nature-wallpapers-widescreen-Is-4K-Wallpaper.jpg?000"
    ]
    
    var imageCache: [String:UIImage?] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.imagePaths.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! ImageCell
        
        cell.cellImageView.image = nil
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let imageCell = cell as? ImageCell {
            imageCell.cellImageView.image = nil
            
            if let image = self.imageCache[self.imagePaths[indexPath.row]] {
                imageCell.cellImageView.image = image
            } else {
                downloadImage(from: self.imagePaths[indexPath.row], scaledTo: imageCell.cellImageView.bounds.size)
            }
        }
    }
}

extension ViewController {
    func downloadImage(from urlString: String, scaledTo size: CGSize) {
        AGCache.shared.downloadWithoutSavingToOffline(from: urlString, size: size.scaledToScreenScale) { (image) in
            self.imageCache[urlString] = image
            self.tableView.reloadRows(at: [[0, self.imagePaths.index(of: urlString)!]], with: .automatic)
        }
    }
}
