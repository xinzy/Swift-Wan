//
//  Then.swift
//  Wan
//
//  Created by Yang on 2020/5/4.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import Foundation

protocol Then { }

extension Then where Self: Any {
    
    /// Makes it available to set properties with closures just after initializing and copying the value types.
    ///
    ///    let frame = CGRect().with {
    ///       $0.origin.x = 10
    ///       $0.size.width = 100
    ///    }
    func with(_ block: (inout Self) throws -> Void) rethrows -> Self {
        var copy = self
        try block(&copy)
        return copy
    }
    
    
     /// Makes it available to execute something with closures.
     ///
     ///    UserDefaults.standard.do {
     ///       $0.set("test", forKey: "username")
     ///       $0.set("test@gmail.com", forKey: "email")
     ///       $0.synchronize()
     ///    }
    func `do`(_ block: (Self) throws -> Void) rethrows {
        try block(self)
    }
}

extension Then where Self: AnyObject {
    
    /// Makes it available to set properties with closures just after initializing.
    ///
    ///    let label = UILabel().then {
    ///       $0.textAlignment = .center
    ///       $0.textColor = UIColor.black
    ///       $0.text = "Hello, World!"
    ///    }
    func then(_ block: (Self) throws -> Void) rethrows -> Self {
        try block(self)
        return self
    }
}

extension NSObject: Then {}

extension Array: Then {}
extension Dictionary: Then {}
extension Set: Then {}

extension CGPoint: Then {}
extension CGRect: Then {}
extension CGSize: Then {}
extension CGVector: Then {}

#if os(iOS) || os(tvOS)
  extension UIEdgeInsets: Then {}
  extension UIOffset: Then {}
  extension UIRectEdge: Then {}
#endif
