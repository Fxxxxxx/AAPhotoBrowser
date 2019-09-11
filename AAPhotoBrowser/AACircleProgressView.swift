//
//  AACircleProgressView.swift
//  uchain
//
//  Created by Fxxx on 2018/11/14.
//  Copyright © 2018 Fxxx. All rights reserved.
//

import UIKit

class AACircleProgressView: UIView {
    
    var radius: CGFloat = 18.0
    var width: CGFloat = 40.0
    private let shapeLayer = CAShapeLayer()
    
    init(in view: UIView) {
        
        super.init(frame: CGRect.init(x: 0, y: 0, width: width, height: width))
        self.backgroundColor = UIColor.clear
        view.addSubview(self)
        self.center = view.center
        
        let color = UIColor.init(white: 1, alpha: 0.75).cgColor
        
        let backLayer = CAShapeLayer.init()
        backLayer.strokeColor = color
        backLayer.fillColor = UIColor.clear.cgColor
        backLayer.lineWidth = 1
        let path = UIBezierPath.init(ovalIn: self.bounds).cgPath
        backLayer.path = path
        self.layer.addSublayer(backLayer)
        
        shapeLayer.fillColor = color
        self.layer.addSublayer(shapeLayer)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setProgress(progress: Float) {
        
        let center = CGPoint.init(x: width / 2, y: width / 2)
        let path = UIBezierPath.init(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(progress * 2 * Float.pi)  , clockwise: true)
        path.addLine(to: center)
        path.close()
        shapeLayer.path = path.cgPath
        
    }
    
}
