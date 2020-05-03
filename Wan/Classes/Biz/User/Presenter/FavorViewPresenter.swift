//
//  FavorViewPresenter.swift
//  Wan
//
//  Created by Yang on 2020/5/1.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import Foundation

class FavorViewPresenter<View>: FavorPresenter where View: FavorView, View: UITableViewController {
    typealias V = View
    var mView: View
    
    private var mPage = 0
    private var isRefresh: Bool { mPage == 0 }
    
    required init(_ view: View) {
        self.mView = view
    }
    
    func refresh() {
        mPage = 0
        fetchFavor()
    }
    
    func fetchFavor() {
        HttpApis.loadCollectList(mPage) { [unowned self] in
            if self.isRefresh {
                self.mView.endRefreshHeader()
            } else {
                self.mView.endLoadMoreFooter()
            }
            
            switch $0 {
            case .success(let list):
                self.mView.showRefreshFooter()
                self.mView.setRefreshFooterStatus(list.over)
                self.mView.showFavor(list.datas, self.isRefresh)
                self.mPage += 1
            case .failure(let msg):
                self.mView.showToast(msg)
            }
        }
    }
    
    func uncollect(_ favor: Favor, _ position: Int) {
        mView.showProgress()
        HttpApis.uncollectOrigin(favor.originId) { [unowned self] in
            self.mView.hideProgress()
            switch $0 {
            case .success(_):
                self.mView.uncollectSuccess(position)
            case .failure(let msg):
                self.mView.showToast(msg)
            }
        }
    }
}
