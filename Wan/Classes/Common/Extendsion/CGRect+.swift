//
//  CGRect+.swift
//  Gank
//
//  Created by Yang on 2020/4/10.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit

extension CGRect {
    
    var left: CGFloat {
        get {
            origin.x
        }
        set {
            origin.x = newValue
        }
    }
    
    var top: CGFloat {
        get {
            origin.y
        }
        set {
            origin.y = newValue
        }
    }
    
    var right: CGFloat {
        get {
            left + width
        }
        set {
            left = newValue - width
        }
    }
    
    var bottom: CGFloat {
        get {
            top + height
        }
        set {
            top = newValue - height
        }
    }
    
    var centerX: CGFloat {
        width / 2
    }
    
    var centerY: CGFloat {
        height / 2
    }
    
    var center: CGPoint {
        CGPoint(x: centerX, y: centerY)
    }
    
    var height: CGFloat {
        get {
            self.size.height
        }
        set {
            self.size.height = newValue
        }
    }
    
    var width: CGFloat {
        get {
            self.size.width
        }
        set {
            self.size.width = newValue
        }
    }
}
