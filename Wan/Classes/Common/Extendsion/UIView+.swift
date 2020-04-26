//
//  UIView+.swift
//  Gank
//
//  Created by Yang on 2020/4/10.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit

extension UIView {
    
    var height: CGFloat {
        get {
            self.bounds.height
        }
        set {
            var newFrame = frame
            newFrame.height = newValue
            self.frame = newFrame
        }
    }
    
    var width: CGFloat {
        get {
            self.bounds.width
        }
        set {
            var newFrame = frame
            newFrame.width = newValue
            self.frame = newFrame
        }
    }
    
    var left: CGFloat {
        get {
            self.frame.left
        }
        set {
            var newFrame = frame
            newFrame.left = newValue
            self.frame = newFrame
        }
    }
    
    var right: CGFloat {
        get {
            self.frame.right
        }
        set {
            var newFrame = frame
            newFrame.right = newValue
            self.frame = newFrame
        }
    }
    
    var top: CGFloat {
        get {
            self.frame.top
        }
        set {
            var newFrame = frame
            newFrame.top = newValue
            self.frame = newFrame
        }
    }
    
    var bottom: CGFloat {
        get {
            self.frame.bottom
        }
        set {
            var newFrame = frame
            newFrame.bottom = newValue
            self.frame = newFrame
        }
    }
    
    ///移除所有子View
    func removeAllSubview() {
        let children = self.subviews
        if children.isEmpty { return }
        for item in children {
            item.removeFromSuperview()
        }
    }
}
