//
//  String+Extendsion.swift
//  Gank
//
//  Created by Yang on 2020/4/8.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    var isNotEmpty: Bool {
        !isEmpty
    }
    
    subscript(range: ClosedRange<Int>) -> String {
        return substring(start: range.first ?? 0, end: range.last ?? self.count)
    }
    
    subscript(range: Range<Int>) -> String {
        return substring(start: range.first ?? 0, end: range.last ?? self.count)
    }
    
    subscript(index: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: 1)]
    }
    
    func substring(start: Int, end: Int? = nil) -> String {
        if start >= self.count || start < 0 || (end != nil && end! <= start) {
            return ""
        }
        
        let startIndex = start == 0 ? self.startIndex : self.index(self.startIndex, offsetBy: start)
        guard let rawEnd = end else {
            return String(self[startIndex ..< self.endIndex])
        }
        let endIndex = rawEnd > self.count ? self.endIndex : self.index(self.startIndex, offsetBy: rawEnd)
        
        return String(self[startIndex ..< endIndex])
    }
    
    func substring(start: Int, count: Int) -> String {
        if start >= self.count || start < 0 || count <= 0 {
            return ""
        }
        let startIndex = start == 0 ? self.startIndex : self.index(self.startIndex, offsetBy: start)
        let endIndex = start + count > self.count ? self.endIndex : self.index(startIndex, offsetBy: count)
        
        return String(self[startIndex ..< endIndex])
    }
    
    func replaceAll(_ dict: [String : String]) -> String {
        return dict.reduce(self) {
            $0.replacingOccurrences(of: $1.key, with: $1.value)
        }
    }
    
}


extension String {
    
    /// 文字宽度
    func width(_ font: UIFont) -> CGFloat {
        (self as NSString).boundingRect(with: .zero, options: .usesLineFragmentOrigin, attributes: [.font : font], context: nil).width
    }
    
    /// 文字宽度
    func width(sizeOfSystem fontSize: CGFloat) -> CGFloat {
        width(UIFont.systemFont(ofSize: fontSize))
    }
    
    /// 文字高度
    func height(font: UIFont, viewWidth: CGFloat) -> CGFloat {
        (self as NSString).boundingRect(with: CGSize(width: viewWidth, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [.font : font], context: nil).height
    }
    
    /// 文字高度
    func height(sizeOfSystem fontSize: CGFloat, viewWidth: CGFloat) -> CGFloat {
        height(font: UIFont.systemFont(ofSize: fontSize), viewWidth: viewWidth)
    }
}
