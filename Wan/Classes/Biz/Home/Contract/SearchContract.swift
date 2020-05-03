//
//  SearchContract.swift
//  Wan
//
//  Created by Yang on 2020/5/2.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import Foundation

protocol SearchView: BaseView {
    
    /// 展示搜索热词
    func showHotKeys(_ keys: [HotKey])
    
    /// 展示搜索结果
    func showSearchResult(_ articles: [Article], _ refresh: Bool)
    
    func endRefreshHeader()
    
    func endLoadMoreFooter()
    
    func setFooterViewLoadStatus(_ hasNoData: Bool)
    
    func setFooterViewHidden(_ hidden: Bool)
}

protocol SearchPresenter: BasePresenter {
    
    /// 加载搜索热词
    func fetchHotKey()
    
    /// 刷新
    func refresh()
    
    /// 搜索
    func search(_ keyword: String)
    
    /// 加载更多数据
    func loadMore()
}
