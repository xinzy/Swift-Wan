//
//  ProjectContract.swift
//  Wan
//
//  Created by Yang on 2020/4/24.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import Foundation

protocol ProjectView: BaseView {
    
    /// 设置Tab
    func setupTabs(_ chapters: [Chapter])
}

protocol ProjectPresenter: BasePresenter {
    
    /// 加载分类数据
    func fetchChapters()
}
