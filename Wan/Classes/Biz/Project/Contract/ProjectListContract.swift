//
//  ProjectListContract.swift
//  Wan
//
//  Created by Yang on 2020/4/24.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import Foundation

protocol ProjectListView: BaseView {
    
    /// 展示列表
    func showProjects(_ list: [Article], _ refresh: Bool)
}

protocol ProjectListPresenter: BasePresenter {
    
    var chapter: Chapter! { set get }
    
    /// 获取项目列表
    func fetchProjectList()
    
    /// 刷新项目
    func refresh()
}
