//
//  AATransitioningDelegate.swift
//  uchain
//
//  Created by Fxxx on 2018/11/14.
//  Copyright © 2018 Fxxx. All rights reserved.
//

import UIKit

public class AATransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    private var isPresented = true
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isPresented = true
        return self
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isPresented = false
        return self
    }
    
//    public func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//        return self
//    }
//
//    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//        return self
//    }
    
}

//extension AATransitioningDelegate: UIViewControllerInteractiveTransitioning {
//    public func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
//
//    }
//}

extension AATransitioningDelegate: UIViewControllerAnimatedTransitioning {
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        if isPresented {
            animationForPresented(using: transitionContext)
        } else {
            animationForDissmissed(using: transitionContext)
        }
        
    }
    
    func animationForPresented(using transitionContext: UIViewControllerContextTransitioning) {
        
        let toView = transitionContext.view(forKey: .to)!
        transitionContext.containerView.addSubview(toView)
        let toCtr = transitionContext.viewController(forKey: .to) as! AAPhotoBrowser
        let originalView = toCtr.delegate.photo(of: toCtr.selectedIndex, with: toCtr).originalView
        guard originalView != nil else {
            transitionContext.completeTransition(true)
            return
        }
        
        let blackView = UIView.init(frame: UIScreen.main.bounds)
        blackView.backgroundColor = UIColor.black
        transitionContext.containerView.addSubview(blackView)
        let newRect = originalView!.convert(originalView!.bounds, to: nil)
        let imageView = UIImageView.init(frame: newRect)
        imageView.image = originalView?.image!
        imageView.contentMode = originalView!.contentMode
        transitionContext.containerView.addSubview(imageView)
        
        UIView.animate(withDuration: toCtr.presentDuration, animations: {
            
            imageView.frame = UIScreen.main.bounds
            imageView.contentMode = .scaleAspectFit
            
        }) { (finish) in
            
            imageView.removeFromSuperview()
            blackView.removeFromSuperview()
            transitionContext.completeTransition(true)
            
        }
        
    }
    
    func animationForDissmissed(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromCtr = transitionContext.viewController(forKey: .from) as! AAPhotoBrowser
        let originalView = fromCtr.delegate.photo(of: fromCtr.selectedIndex, with: fromCtr).originalView
        guard originalView != nil else {
            transitionContext.completeTransition(true)
            return
        }
        
        let cell = fromCtr.collectionView.cellForItem(at: IndexPath.init(item: fromCtr.selectedIndex, section: 0)) as! AAPhotoCell
        let showView = cell.imageView!
        transitionContext.containerView.addSubview(showView)
        let newRect = originalView!.convert(originalView!.bounds, to: nil)
        UIView.animate(withDuration: fromCtr.dissmissDuration, animations: {
            
            showView.frame = newRect
            fromCtr.view.backgroundColor = UIColor.clear
            
        }) { (finish) in
            transitionContext.completeTransition(true)
        }
        
    }
    
}
