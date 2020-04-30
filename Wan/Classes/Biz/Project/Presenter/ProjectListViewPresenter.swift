//
//  ProjectListViewPresenter.swift
//  Wan
//
//  Created by Yang on 2020/4/24.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import Foundation

class ProjectListViewPresenter<View>: ProjectListPresenter where View: ProjectListView, View: UITableViewController {
    typealias V = View
    
    var chapter: Chapter!
    var mView: View
    
    private var mPage = 1
    private var isRefresh: Bool { mPage == 1 }
    
    required init(_ view: View) {
        self.mView = view
    }
    
    func fetchProjectList() {
        HttpApis.loadProjectArticles(chapter.id, mPage) { [unowned self] in
            if self.isRefresh {
                self.mView.endRefreshHeader()
            } else {
                self.mView.endLoadMoreFooter()
            }
            
            switch $0 {
            case .success(let list):
                let articles = list.datas
                self.mView.showProjects(articles, self.isRefresh)
                self.mPage += 1
                self.mView.showRefreshFooter()
                self.mView.setRefreshFooterStatus(list.over)
                
            case .failure(let msg):
                self.mView.showToast(msg)
            }
        }
    }
    
    func refresh() {
        mPage = 1
        fetchProjectList()
    }
}
