//
//  Functions.swift
//  Gank
//
//  Created by Yang on 2020/4/8.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import Foundation
import UIKit

func xPrint(file: NSString = #file, fun: String = #function, line: Int = #line, _ msg: Any...) {
    #if DEBUG
    let prefix = "\(file.lastPathComponent) \(fun) \(line): "
    print(prefix, msg)
    #else
//    print(file.lastPathComponent, fun, line, msg)
    #endif
}

/// 设备边框
func mainBounds() -> CGRect {
    UIScreen.main.bounds
}

func formatTime(millisecond: Int) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(millisecond / 1000))
    let delta = Date().timeIntervalSince1970 - date.timeIntervalSince1970
    if delta < 60 {
        return "刚刚"
    }
    var time = delta / 60
    if time < 60 {
        return "\(Int(time))分钟前"
    }
    time /= 60
    if time < 24 {
        return "\(Int(time))小时前"
    }
    time /= 24
    if time < 30 {
        return "\(Int(time))天前"
    }
    
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "YY-MM-dd"
    return dateFormat.string(from: date)
}
