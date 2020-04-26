//
//  Macro.swift
//  Wan
//
//  Created by Yang on 2020/4/21.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import Foundation
import UIKit

let xSelectedColor: UIColor = UIColor(fromHexString: "#f45859")
let xDefaultColor: UIColor = UIColor(fromHexString: "#515351")

/// 设备高度
var screenWidth: CGFloat {
    mainBounds().width
}

/// 设备宽度
var screenHeight: CGFloat {
    mainBounds().height
}

/// 是否是全面屏设备
var isFullScreen: Bool {
    if #available(iOS 11, *) {
        guard let window = UIApplication.shared.keyWindow else {
            return false
        }
        return window.safeAreaInsets.bottom > 0
    }
    return false
}

/// 状态栏高度
var statusBarHeight: CGFloat {
    UIApplication.shared.statusBarFrame.height
}

/// 设备底部高度
var safeAreaBottom: CGFloat {
    isFullScreen ? 34 : 0
}
