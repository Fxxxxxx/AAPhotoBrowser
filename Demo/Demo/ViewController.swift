//
//  ViewController.swift
//  Demo
//
//  Created by Fxxx on 2018/11/16.
//  Copyright © 2018 Aaron Feng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        layout.itemSize = CGSize.init(width: (AAscreenW - 20) / 3, height: (AAscreenW - 20) / 3)
        layout.minimumInteritemSpacing = 10.0
        layout.minimumLineSpacing = 10.0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AACell", for: indexPath) as! AACell
        let picName = indexPath.item % 9
        cell.imageView.image = UIImage.init(named: "\(picName).jpeg")
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let broswer = AAPhotoBrowser.init(with: self)
        broswer.selectedIndex = indexPath.item
        broswer.presentDuration = 0.3
        broswer.dissmissDuration = 0.3
        self.present(broswer, animated: true, completion: nil)
        
    }

}

extension ViewController: AAPhotoBrowserProtocol {
    
    func numberOfPhotos(with browser: AAPhotoBrowser) -> Int {
        return 9
    }
    
    func photo(of index: Int, with browser: AAPhotoBrowser) -> AAPhoto {
        
        let cell = collectionView.cellForItem(at: IndexPath.init(item: index, section: 0)) as! AACell
        let photo = AAPhoto.init(image: UIImage.init(named: "\(index % 9).jpeg")!, originalView: cell.imageView)
//        let photo = AAPhoto.init(urlString: String, placeholderImage: UIImage?, originalView: UIImageView?)
        return photo
        
    }
    
    func didLongPressPhoto(at index: Int, with browser: AAPhotoBrowser) {
        
        let activity = UIActivityViewController.init(activityItems: [UIImage.init(named: "\(index).jpeg")!], applicationActivities: nil)
        if UIDevice.current.userInterfaceIdiom == .pad {
            activity.popoverPresentationController?.sourceRect = CGRect.init(origin: browser.view.center, size: CGSize.init(width: 10, height: 10))
            activity.popoverPresentationController?.sourceView = browser.view
        }
        activity.completionWithItemsHandler = { (activityType, completed, returnedItems, activityError) in
            
            if completed {
                print("操作成功")
            } else if activityError != nil {
                print("操作失败")
            }
            
        }
        DispatchQueue.main.async {
            browser.present(activity, animated: true, completion: nil)
        }
        
    }
    
}
