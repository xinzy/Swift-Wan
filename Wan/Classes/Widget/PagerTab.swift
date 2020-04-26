//
//  PagerTab.swift
//  Wan
//
//  Created by Yang on 2020/4/25.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit
import IBAnimatable

protocol PagerTabDelegate {
    func pagerTab(_ tab: PagerTab, toIndex index: Int, toTitle title: String)
}

class PagerTab: UIView {
    var delegate: PagerTabDelegate?

    var itemWidth: CGFloat = 56
    var horizontalSpacing: CGFloat = 10
    
    var indicatorHeight: CGFloat = 2 {
        didSet {
            if oldValue != indicatorHeight {
                setupUi()
            }
        }
    }
    var defaultColor: UIColor = xDefaultColor {
        didSet {
            if oldValue != defaultColor {
                setupUi()
            }
        }
    }
    var selectedColor: UIColor = xSelectedColor {
        didSet {
            if oldValue != selectedColor {
                setupUi()
            }
        }
    }
    
    var tabTitles: [String] = ["体系", "导航"] {
        didSet {
            setupUi()
        }
    }
    
    private var indicatorView: UIView!
    private var currentSelectedIndex: Int = 0
    private var lastSelectedButton: UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUi()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUi()
    }
    
    
}

//MARK: - Setup View
extension PagerTab {
    
    private func setupUi() {
        self.removeAllSubview()
        lastSelectedButton = nil
        
        guard tabTitles.isNotEmpty else { return }
        
        indicatorView = createIndicatorView()
        var offsetX: CGFloat = 0
        for (index, item) in tabTitles.enumerated() {
            let button = UIButton()
            button.tag = index
            button.setTitle(item, for: .normal)
            button.setTitleColor(defaultColor, for: .normal)
            button.setTitleColor(selectedColor, for: .selected)
            
            button.frame = CGRect(x: offsetX, y: 0, width: itemWidth, height: self.height)
            offsetX += itemWidth + horizontalSpacing
            
            button.isSelected = index == currentSelectedIndex
            button.addTarget(self, action: #selector(onItemClick(_:)), for: .touchUpInside)
            
            addSubview(button)
            
            if index == currentSelectedIndex {
                lastSelectedButton = button
            }
        }
        
        indicatorView.frame = CGRect(x: CGFloat(currentSelectedIndex) * (itemWidth + horizontalSpacing) , y: height - indicatorHeight, width: itemWidth, height: indicatorHeight)
        addSubview(indicatorView)
    }
    
    private func createIndicatorView() -> UIView {
        let view = AnimatableView(frame: CGRect(x: 0, y: 0, width: itemWidth, height: indicatorHeight))
        view.backgroundColor = xSelectedColor
        view.cornerRadius = indicatorHeight / 2
        return view
    }
    
    @objc private func onItemClick(_ sender: UIButton) {
        let tag = sender.tag
        
        lastSelectedButton?.isSelected = false
        sender.isSelected = true
        
        lastSelectedButton = sender
        currentSelectedIndex = tag
        delegate?.pagerTab(self, toIndex: tag, toTitle: tabTitles[tag])
        
        UIView.animate(withDuration:                                                     0.3) {
            self.indicatorView.frame = CGRect(x: CGFloat(tag) * (self.itemWidth + self.horizontalSpacing), y: self.height - self.indicatorHeight, width: self.itemWidth, height: self.indicatorHeight)
        }
    }
}
