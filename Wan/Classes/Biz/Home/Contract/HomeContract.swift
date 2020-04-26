//
//  HomeContract.swift
//  Wan
//
//  Created by Yang on 2020/4/21.
//  Copyright © 2020 Xinzy. All rights reserved.
//

protocol HomeView: BaseView {
    /// 显示Banner数据
    func showBanner(_ banners: [Banner])
    
    /// 置顶文章
    func showArticles(_ articles: [Article], _ replace: Bool)
}

protocol HomePresenter: BasePresenter {
    
    /// 刷新首页数据
    func refresh()
    
    /// 获取Banner数据
    func fetchHomeBanner()
    
    /// 置顶文章
    func fetchTopArticles()
    
    /// 首页文章列表
    func fetchHomeArticles()
}
