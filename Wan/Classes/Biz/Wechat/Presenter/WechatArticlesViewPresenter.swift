//
//  WechatArticlesViewPresenter.swift
//  Wan
//
//  Created by Yang on 2020/4/23.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import Foundation

class WechatArticlesViewPresenter<View>: WechatArticlesPresenter where View: WechatArticlesView, View: UITableViewController {
    typealias V = View
    var mView: View
    var chapter: Chapter!
    
    private var mPage = 1
    private var isRefresh: Bool {
        mPage == 1
    }
    
    required init(_ view: View) {
        self.mView = view
    }
    
    func refresh() {
        mPage = 1
        fetchArticles()
    }
    
    func fetchArticles() {
        HttpApis.loadWechatArticles(mPage, chapter.id) { [unowned self] result in
            if self.isRefresh {
                self.mView.endRefreshHeader()
            } else {
                self.mView.endRefreshFooter()
            }
            
            switch result {
            case .success(let list):
                self.mView.showArticle(list.datas, self.isRefresh)
                self.mPage += 1
                self.mView.showRefreshFooter()
                self.mView.setRefreshFooterStatus(list.over)
                
            case .failure(let msg):
                self.mView.showToast(msg)
            }
        }
    }
}
