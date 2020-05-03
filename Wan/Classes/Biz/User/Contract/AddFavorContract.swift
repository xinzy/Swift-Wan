//
//  AddFavorContract.swift
//  Wan
//
//  Created by Yang on 2020/5/1.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import Foundation

protocol AddFavorView: BaseView {
    /// 添加成功
    func addSuccess()
}

protocol AddFavorPresenter: BasePresenter {
    
    /// 添加收藏
    func addFavor(_ title: String, _ author: String, _ link: String)
}
