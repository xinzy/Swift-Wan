//
//  ScoreHistoryContract.swift
//  Wan
//
//  Created by Yang on 2020/5/2.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import Foundation

protocol ScoreHistoryView: BaseView {
    
    /// 展示积分历史
    func showScores(_ scores: [ScoreHistory], _ refresh: Bool)
}

protocol ScoreHistoryPresenter: BasePresenter {
    
    /// 刷新
    func refresh()
    
    /// 获取历史积分
    func fetchScoreList()
}
