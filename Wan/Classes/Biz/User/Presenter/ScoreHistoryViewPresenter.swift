//
//  ScoreHistoryViewPresenter.swift
//  Wan
//
//  Created by Yang on 2020/5/2.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import Foundation

class ScoreHistoryViewPresenter<View>: ScoreHistoryPresenter where View: ScoreHistoryView, View: UITableViewController {
    typealias V = View
    var mView: View
    
    private var mPage: Int = 1
    private var isRefresh: Bool { mPage == 1 }
    
    required init(_ view: View) {
        self.mView = view
    }
    
    func refresh() {
        mPage = 1
        fetchScoreList()
    }
    
    func fetchScoreList() {
        HttpApis.loadScoreHistory(mPage) { [unowned self] in
            if self.isRefresh {
                self.mView.endRefreshHeader()
            } else {
                self.mView.endLoadMoreFooter()
            }
            
            switch $0 {
            case .success(let list):
                self.mView.showScores(list.datas, self.isRefresh)
                self.mView.setRefreshFooterStatus(list.over)
                self.mView.showRefreshFooter()
                self.mPage += 1
            case .failure(let msg):
                self.mView.showToast(msg)
            }
        }
    }
}
