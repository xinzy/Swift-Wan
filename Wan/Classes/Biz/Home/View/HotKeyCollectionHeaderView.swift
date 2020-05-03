//
//  HotKeyCollectionHeaderView.swift
//  Wan
//
//  Created by Yang on 2020/5/2.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit

class HotKeyCollectionHeaderView: UICollectionReusableView {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "搜索热词"
        label.textColor = UIColor(fromHexString: "#999999")
        label.font = UIFont.systemFont(ofSize: 16)
        label.sizeToFit()
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(12)
        }
    }
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 24))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
