//
//  FavorContract.swift
//  Wan
//
//  Created by Yang on 2020/5/1.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import Foundation

protocol FavorView: BaseView {
    
    /// 展示收藏
    func showFavor(_ favors: [Favor], _ refresh: Bool)
    
    /// 取消收藏成功
    func uncollectSuccess(_ index: Int)
}

protocol FavorPresenter: BasePresenter {
    
    /// 刷新
    func refresh()
    
    /// 获取收藏列表
    func fetchFavor()
    
    /// 取消收藏
    func uncollect(_ favor: Favor, _ position: Int)
}
