//
//  UIColor+Extendstion.swift
//  Gank
//
//  Created by Yang on 2020/4/8.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(fromHexString rgba: String) {
        var red: Int
        var green: Int
        var blue: Int
        var alpha: Int
        
        let hex = rgba.starts(with: "#") ? rgba.substring(start: 1) : rgba
        switch hex.count {
        case 8:
            red = Int(hex.substring(start: 0, count: 2), radix: 16) ?? 0
            green = Int(hex.substring(start: 2, count: 2), radix: 16) ?? 0
            blue = Int(hex.substring(start: 4, count: 2), radix: 16) ?? 0
            alpha = Int(hex.substring(start: 6, count: 2), radix: 16) ?? 0
        
        case 6:
            red = Int(hex.substring(start: 0, count: 2), radix: 16) ?? 0
            green = Int(hex.substring(start: 2, count: 2), radix: 16) ?? 0
            blue = Int(hex.substring(start: 4, count: 2), radix: 16) ?? 0
            alpha = 255
            
        case 4:
            red = 16 * (Int(hex.substring(start: 0, count: 1), radix: 16) ?? 0)
            green = 16 * (Int(hex.substring(start: 1, count: 1), radix: 16) ?? 0)
            blue = 16 * (Int(hex.substring(start: 2, count: 1), radix: 16) ?? 0)
            alpha = 16 * (Int(hex.substring(start: 3, count: 1), radix: 16) ?? 0)
            
        case 3:
            red = 16 * (Int(hex.substring(start: 0, count: 1), radix: 16) ?? 0)
            green = 16 * (Int(hex.substring(start: 1, count: 1), radix: 16) ?? 0)
            blue = 16 * (Int(hex.substring(start: 2, count: 1), radix: 16) ?? 0)
            alpha = 255
            
        default:
            red = 0
            green = 0
            blue = 0
            alpha = 0
        }
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha) / 255.0)
    }
    
    func image() -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(self.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
