//
//  CGFloat+.swift
//  Wan
//
//  Created by Yang on 2020/5/4.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit

extension CGFloat {
    static func *(_ val: CGFloat, _ other: Int) -> CGFloat {
        val * CGFloat(other)
    }
}

