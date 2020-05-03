//
//  RankViewPresenter.swift
//  Wan
//
//  Created by Yang on 2020/5/1.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import Foundation

class RankViewPresenter<View>: RankPresenter where View: RankView, View: UITableViewController {
    typealias V = View
    
    var mView: View
    
    private var mPage = 1
    private var isRefresh: Bool { mPage == 1 }
    
    required init(_ view: View) {
        self.mView = view
    }
    
    func refresh() {
        self.mPage = 1
        fetchScore()
    }
    
    func fetchScore() {
        HttpApis.loadRank(mPage) { [unowned self] in
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
