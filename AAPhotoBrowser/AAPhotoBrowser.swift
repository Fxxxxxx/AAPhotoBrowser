//
//  AAPhotoBrowser.swift
//  uchain
//
//  Created by Aaron on 2018/11/14.
//  Copyright © 2018 Fxxx. All rights reserved.
//

import UIKit

let AAscreenW = UIScreen.main.bounds.size.width
let AAscreenH = UIScreen.main.bounds.size.height

public class AAPhotoBrowser: UIViewController {
    
    public weak var delegate: AAPhotoBrowserProtocol!
    public var presentDuration: TimeInterval = 0.3          //显示动画时间
    public var dissmissDuration: TimeInterval = 0.3         //隐藏动画时间
    public var selectedIndex = 0                            //当前显示图片的序号
    var collectionView: UICollectionView!
    private var pageControl: UIPageControl!
    private let transDelegate = AATransitioningDelegate()
    
    private var draggingX: CGFloat = 0.0
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(with delegate: AAPhotoBrowserProtocol) {
        
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
        self.transitioningDelegate = transDelegate
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
        
    }
    
    override public func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        self.view.clipsToBounds = true
        
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = UIScreen.main.bounds.size
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        collectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.register(AAPhotoCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = .normal
        self.view.addSubview(collectionView)
        collectionView.selectItem(at: IndexPath.init(item: selectedIndex, section: 0), animated: false, scrollPosition: .left)
        
        pageControl = UIPageControl.init(frame: CGRect.init(x: 0, y: AAscreenH - 50, width: AAscreenW, height: 20))
        pageControl.numberOfPages = self.delegate.numberOfPhotos(with: self)
        pageControl.currentPage = selectedIndex
        pageControl.isUserInteractionEnabled = false
        self.view.addSubview(pageControl)
        pageControl.isHidden = delegate.numberOfPhotos(with: self) == 1
        
    }
    
    deinit {
//        print("AAPhotoBrowser销毁")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func disAction() {
        self.dismiss(animated: true, completion: nil)
    }

}

extension AAPhotoBrowser: UICollectionViewDataSource, UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.delegate.numberOfPhotos(with: self)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AAPhotoCell
        cell.setPhoto(photo: self.delegate.photo(of: indexPath.item, with: self))
        cell.index = indexPath.item
        cell.browser = self
        return cell
        
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        draggingX = scrollView.contentOffset.x
    }
    
    public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        
        let fix: CGFloat = draggingX < scrollView.contentOffset.x ? 0.98 : 0.02
        var page = Int(scrollView.contentOffset.x / (AAscreenW + 10) + fix)
        let photos = self.delegate.numberOfPhotos(with: self) - 1
        page = page > photos ? photos : page
        selectedIndex = page
        pageControl.currentPage = selectedIndex
        
        let x = (AAscreenW + 10.0) * CGFloat(page)
        scrollView.setContentOffset(CGPoint.init(x: x, y: 0), animated: true)
        
        delegate.didDisplayPhoto?(at: page, with: self)
        
    }
    
}
