//
//  AACircleProgressView.swift
//  uchain
//
//  Created by Fxxx on 2018/11/14.
//  Copyright © 2018 Fxxx. All rights reserved.
//

import UIKit

class AACircleProgressView: UIView {
    
    var radius: CGFloat = 15.0
    private let shapeLayer = CAShapeLayer()
    
    init(in view: UIView) {
        
        super.init(frame: CGRect.init(x: 0, y: 0, width: radius * 2, height: radius * 2))
        self.backgroundColor = UIColor.clear
        view.addSubview(self)
        self.center = view.center
        
        let backLayer = CAShapeLayer.init()
        backLayer.strokeColor = UIColor.gray.cgColor
        backLayer.fillColor = UIColor.clear.cgColor
        backLayer.lineWidth = 5
        let path = UIBezierPath.init(ovalIn: self.bounds).cgPath
        backLayer.path = path
        self.layer.addSublayer(backLayer)
        
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 5
        self.layer.addSublayer(shapeLayer)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setProgress(progress: Float) {
        
        let path = UIBezierPath.init(arcCenter: CGPoint.init(x: radius, y: radius), radius: radius, startAngle: 0, endAngle: CGFloat(progress * 2 * Float.pi)  , clockwise: true)
        shapeLayer.path = path.cgPath
        
    }
    
}
