//
//  AAPhoto.swift
//  uchain
//
//  Created by Fxxx on 2018/11/14.
//  Copyright © 2018 Fxxx. All rights reserved.
//

import UIKit

public final class AAPhoto: NSObject {
    
    public var image: UIImage?
    public var urlString: String?
    public var placeholderImage : UIImage?
    public var originalView: UIImageView?
    
    public init(image: UIImage, originalView: UIImageView? = nil) {
        super.init()
        self.image = image
        self.originalView = originalView
    }
    
    public init(urlString: String, placeholderImage: UIImage? = nil, originalView: UIImageView? = nil) {
        super.init()
        self.urlString = urlString
        self.placeholderImage = placeholderImage
        self.originalView = originalView
    }
    
}
