//
//  AddFavorViewPresenter.swift
//  Wan
//
//  Created by Yang on 2020/5/1.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import Foundation

struct AddFavorViewPresenter<View>: AddFavorPresenter where View: AddFavorView, View: UIViewController {
    typealias V = View
    var mView: View
    
    init(_ view: View) {
        self.mView = view
    }
    
    func addFavor(_ title: String, _ author: String, _ link: String) {
        guard title.isNotEmpty else {
            mView.showToast("请先输入标题")
            return
        }
        guard author.isNotEmpty else {
            mView.showToast("请先输入作者")
            return
        }
        guard link.isNotEmpty else {
            mView.showToast("请先输入链接")
            return
        }
        mView.showProgress()
        
        HttpApis.addCollect(title, author, link) {
            self.mView.hideProgress()
            
            switch $0 {
            case .success(_):
                self.mView.addSuccess()
            case .failure(let msg):
                self.mView.showToast(msg)
            }
        }
    }
}
