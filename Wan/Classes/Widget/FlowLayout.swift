//
//  FlexBoxLayout.swift
//  Wan
//
//  Created by Yang on 2020/4/24.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit

protocol FlowLayoutDataSource {
    
    /// 子View数量
    func numberOfItems() -> Int
    
    /// 单个子View尺寸
    func flowLayout(_ flowLayout: FlowLayout, itemSizeOf index: Int) -> CGSize
    
    /// 创建子View
    func flowLayout(_ flowLayout: FlowLayout, viewOf index: Int) -> UIView
}

/// 流式布局
class FlowLayout: UIView {
    
    var layoutEdgeInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    var verticalSpacing: CGFloat = 0
    var horizontalSpacing: CGFloat = 0
    
    var dataSource: FlowLayoutDataSource?
    
    override func layoutSubviews() {
        guard let dataSource = self.dataSource else { return }
        
        let numberOfItems = dataSource.numberOfItems()
        
        var offsetX: CGFloat = layoutEdgeInsets.left
        var offsetY: CGFloat = layoutEdgeInsets.top
        var lineHeight: CGFloat = 0
        
        for index in 0 ..< numberOfItems {
            let size = dataSource.flowLayout(self, itemSizeOf: index)
            let view = dataSource.flowLayout(self, viewOf: index)

            if offsetX + size.width + layoutEdgeInsets.right < self.width {
                // 当前行能放得下
                let frame = CGRect(x: offsetX, y: offsetY, width: size.width, height: size.height)
                
                view.frame = frame
                offsetX += size.width + horizontalSpacing
                lineHeight = max(lineHeight, size.height)
            } else {
                offsetX = layoutEdgeInsets.left
                offsetY += lineHeight + verticalSpacing
                lineHeight = 0
                
                let frame = CGRect(x: offsetX, y: offsetY, width: size.width, height: size.height)
                view.frame = frame
                
                offsetX += size.width + horizontalSpacing
            }
        }
        let contentHeight = offsetY + lineHeight + layoutEdgeInsets.bottom
        self.height = contentHeight
        
        xPrint("layoutSubviews", contentHeight)
//        self.sizeToFit()
        self.superview?.layoutIfNeeded()
    }
    
    func reloadData() {
        layoutIfNeeded()
    }
}
