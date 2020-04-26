//
//  TagsView.swift
//  Wan
//
//  Created by Yang on 2020/4/26.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit
import IBAnimatable

class TagLayout: UIView {

    /// 水平间距
    var horizontalSpacing: CGFloat = 5
    /// 垂直间距
    var verticalSpacing: CGFloat = 5
    
    var itemHeight: CGFloat = 24
    var itemStrokeWidth: CGFloat = 1
    var itemStrokeColor: UIColor = UIColor(fromHexString: "#FF8447")
    var itemTextColor: UIColor = UIColor(fromHexString: "#FF8447")
    var itemFontSize: CGFloat = 14
    var itemHorizontalPadding: CGFloat = 16
    
    /// 边距
    var layoutInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    
    /// 展示的Tags
    var tags: [String] = [String]() {
        didSet {
            createTags()
        }
    }
    
    /// 内容总宽度
    private var contentHeight: CGFloat = 0 {
        didSet {
            if contentHeight != oldValue {
                onContentHeightChanged?(contentHeight)
            }
        }
    }
    
    var onContentHeightChanged: ((CGFloat) -> Void)? = nil
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: self.width, height: contentHeight)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createTags()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createTags()
    }

}

//MARK: - 创建Tag
extension TagLayout {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if subviews.isEmpty {
            contentHeight = layoutInsets.top + layoutInsets.bottom
            self.height = contentHeight
            return
        }
        
        var offsetX = layoutInsets.left
        var offsetY = layoutInsets.top
        
        let childrenCount = subviews.count
        for (index, child) in subviews.enumerated() {
            if offsetX + child.width < self.width - layoutInsets.right { // 当前行能放得下
                child.frame = CGRect(x: offsetX, y: offsetY, width: child.width, height: child.height)
                offsetX += child.width + horizontalSpacing
            } else { // 当前行放不下，则换行
                offsetY += child.height + verticalSpacing
                offsetX = layoutInsets.left
                child.frame = CGRect(x: offsetX, y: offsetY, width: child.width, height: child.height)
                offsetX += child.width + horizontalSpacing
            }
            
            if index == childrenCount - 1 {
                contentHeight = offsetY + child.height + layoutInsets.bottom
            }
        }
        
//        if intrinsicContentSize != self.bounds.size{
//            invalidateIntrinsicContentSize()
//        }
//        self.height = contentHeight
    }
    
    /// 创建Tag
    private func createTags() {
        removeAllSubview()
        guard tags.isNotEmpty else { return }
        
        for (index, tag) in tags.enumerated() {
            let button = AnimatableButton(type: .custom)
            
            button.tag = index
            button.titleLabel?.font = UIFont.systemFont(ofSize: itemFontSize)
            button.setTitle(tag, for: .normal)
            button.setTitleColor(itemTextColor, for: .normal)
            button.cornerRadius = itemHeight / 2
            button.borderColor = itemStrokeColor
            button.borderWidth = itemStrokeWidth
            
            let width = tag.width(sizeOfSystem: itemFontSize) + itemHorizontalPadding * 2 + 4
            button.frame = CGRect(x: 0, y: 0, width: width, height: itemHeight)
            
            addSubview(button)
        }
    }
}
