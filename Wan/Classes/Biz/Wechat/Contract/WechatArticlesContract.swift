//
//  WechatArticlesContract.swift
//  Wan
//
//  Created by Yang on 2020/4/23.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import Foundation

protocol WechatArticlesView: BaseView {
    
    /// 展示文章，刷新UI
    func showArticle(_ articles: [Article], _ refresh: Bool)
    
    /// 隐藏刷新头
    func endRefreshHeader()
    
    /// 隐藏刷新Footer
    func endRefreshFooter()
}

protocol WechatArticlesPresenter: BasePresenter {
    
    /// 刷新页面
    func refresh()
    
    /// 加载文章列表
    func fetchArticles()
}
