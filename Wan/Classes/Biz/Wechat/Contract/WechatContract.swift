//
//  WechatContract.swift
//  Wan
//
//  Created by Yang on 2020/4/23.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import Foundation

protocol WechatView: BaseView {
    
    /// 创建Tab
    func setupTabs(_ chapters: [Chapter])
}

protocol WechatPresenter: BasePresenter {
    /// 加载公众号列表
    func fetchWechat()
}
