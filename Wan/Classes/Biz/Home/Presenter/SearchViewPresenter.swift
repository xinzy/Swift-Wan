//
//  SearchViewPresenter.swift
//  Wan
//
//  Created by Yang on 2020/5/2.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import Foundation

class SearchViewPresenter<View>: SearchPresenter where View: SearchView, View: UIViewController {
    typealias V = View
    var mView: View
    
    private var mKeyword: String = ""
    private var mUniqueSearchId: Int = 0
    private var mPage = 0
    private var isRefresh: Bool { mPage == 0 }
    
    required init(_ view: View) {
        self.mView = view
    }
    
    func fetchHotKey() {
        mView.showProgress()
        
        HttpApis.loadHotKey { [unowned self] in
            self.mView.hideProgress()
            
            switch $0 {
            case .success(let keys):
                self.mView.showHotKeys(keys)
            case .failure(let msg):
                self.mView.showToast(msg)
            }
        }
    }
    
    func refresh() {
        mPage = 0
        fetchResult()
    }
    
    func search(_ keyword: String) {
        mUniqueSearchId += 1
        let uniqueId = mUniqueSearchId
        mPage = 0
        
        mKeyword = keyword
        fetchResult { uniqueId == self.mUniqueSearchId }
    }
    
    func loadMore() {
        guard mKeyword.isNotEmpty else { return }
        fetchResult()
    }
    
    private func fetchResult(needShowResult: (() -> Bool)? = nil) {
        if isRefresh {
            mView.setFooterViewHidden(true)
        }
        
        HttpApis.loadSearchResult(mPage, mKeyword) { [unowned self] in
            if self.isRefresh {
                self.mView.endRefreshHeader()
            } else {
                self.mView.endLoadMoreFooter()
            }
            
            switch $0 {
            case .success(let list):
                
                if needShowResult == nil || needShowResult!() {
                    self.mView.setFooterViewLoadStatus(list.over)
                    self.mView.showSearchResult(list.datas, self.isRefresh)
                    self.mView.setFooterViewHidden(false)
                    
                    self.mPage += 1
                }
            case .failure(let msg):
                self.mView.showToast(msg)
            }
        }
    }
}
