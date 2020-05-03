//
//  RankContract.swift
//  Wan
//
//  Created by Yang on 2020/5/1.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import Foundation

protocol RankView: BaseView {
    
    /// 展示排行榜
    func showScores(_ scores: [Score], _ refresh: Bool)
}

protocol RankPresenter: BasePresenter {
    
    /// 刷新
    mutating func refresh()
    
    /// 加载排行榜
    mutating func fetchScore()
}
