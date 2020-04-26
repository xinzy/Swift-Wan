//
//  HomeViewPresenter.swift
//  Wan
//
//  Created by Yang on 2020/4/23.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import Foundation

class HomeViewPresenter<View>: HomePresenter where View: HomeView, View: UITableViewController {
    typealias V = View
    var mView: View

    private var mPage: Int = 0 // 首页文章列表分页从0开始
    private var mTempArticles: [Article]? = nil
    
    private var isFirstPage: Bool { mPage == 0 }
    
    required init(_ view: View) {
        self.mView = view
    }
    
    func refresh() {
        mPage = 0
        mTempArticles = nil
        
        fetchHomeBanner()
        fetchTopArticles()
        fetchHomeArticles()
    }
    
    func fetchHomeBanner() {
        HttpApis.loadHomeBanner { [unowned self] result in
            switch result {
            case let .success(banners):
                self.mView.showBanner(banners)
                
            case let .failure(msg):
                xPrint(msg)
            }
        }
    }
    
    func fetchTopArticles() {
        HttpApis.loadHomeTopArticles { [unowned self] result in
            switch result {
            case .success(var articles):
                if let arts = self.mTempArticles {
                    articles.append(contentsOf: arts)
                    self.mView.showArticles(articles, true)
                } else {
                    self.mTempArticles = articles
                }
            case .failure(let msg):
                self.mView.showToast(msg)
            }
        }
    }
    
    func fetchHomeArticles() {
        HttpApis.loadHomeArticles(mPage) { [unowned self] result in
            if self.isFirstPage {
                self.mView.endRefreshHeader()
            } else {
                self.mView.endLoadMoreFooter()
            }
            
            switch result {
            case .success(let list):
                var articles = list.datas
                if !self.isFirstPage {
                    self.mView.showArticles(articles, false)
                } else {
                    if let arts = self.mTempArticles {
                        articles.insert(contentsOf: arts, at: 0)
                        self.mView.showArticles(articles, true)
                    } else {
                        self.mTempArticles = articles
                    }
                }
                self.mPage += 1
                self.mView.showRefreshFooter()
                self.mView.setRefreshFooterStatus(list.over)
                
            case .failure(let msg):
                self.mView.showToast(msg)
            }
        }
    }
    
}
