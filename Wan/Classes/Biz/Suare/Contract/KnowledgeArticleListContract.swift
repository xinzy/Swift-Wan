//
//  KnowledgeArticleListContract.swift
//  Wan
//
//  Created by Yang on 2020/4/30.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import Foundation

protocol KnowledgeArticleListView: BaseView {
    
    /// 刷新数据
    func showArticle(_ articles: [Article], _ refresh: Bool)
}

protocol KnowledgeArticleListPresenter: BasePresenter {
    
    /// 刷新
    func refresh()
    
    /// 获取文章列表
    func fetchArticles()
}
