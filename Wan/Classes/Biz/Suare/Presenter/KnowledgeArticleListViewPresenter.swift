//
//  KnowledgeArticleListViewPresenter.swift
//  Wan
//
//  Created by Yang on 2020/4/30.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import Foundation

class KnowledgeArticleListViewPresenter<View>: KnowledgeArticleListPresenter where View: KnowledgeArticleListView, View: UITableViewController {
    
    typealias V = View
    var mView: View
    var chapter: Chapter!
    
    private var mPage: Int = 0
    private var isRefresh: Bool {
        mPage == 0
    }
    
    required init(_ view: View) {
        self.mView = view
    }
    
    func refresh() {
        mPage = 0
        fetchArticles()
    }
    
    func fetchArticles() {
        HttpApis.loadKnowledgeArticles(chapter.id, mPage) { [unowned self] in
            if self.isRefresh {
                self.mView.endRefreshHeader()
            } else {
                self.mView.endLoadMoreFooter()
            }
            
            switch $0 {
            case .success(let list):
                self.mView.showArticle(list.datas, self.isRefresh)
                self.mView.setRefreshFooterStatus(list.over)
                self.mView.showRefreshFooter()
                self.mPage += 1
                
            case .failure(let msg):
                self.mView.showToast(msg)
            }
        }
    }
}
