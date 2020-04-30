//
//  RegisterViewPresenter.swift
//  Wan
//
//  Created by Yang on 2020/4/29.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import Foundation

class RegisterViewPresenter<View>: RegisterPresenter where View: RegisterView, View: UIViewController {
    typealias V = View
    
    var mView: View
    
    required init(_ view: View) {
        self.mView = view
    }
    
    func register(_ username: String, _ password: String, _ confirm: String) {
        guard username.isNotEmpty else {
            mView.showToast("请输入用户名")
            return
        }
        guard password.isNotEmpty, confirm.isNotEmpty else {
            mView.showToast("请输入密码或重复密码")
            return
        }
        guard password == confirm else {
            mView.showToast("两次密码不一致")
            return
        }
        
        mView.showProgress()
        
        HttpApis.register(username, password, confirm) { [unowned self] in
            self.mView.hideProgress()
            switch $0 {
            case .success(_):
                self.mView.registerSuccess()
            case .failure(let msg):
                self.mView.showToast(msg)
            }
        }
    }
}
