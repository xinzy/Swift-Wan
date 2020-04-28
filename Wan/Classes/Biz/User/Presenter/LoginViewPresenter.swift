//
//  File.swift
//  Wan
//
//  Created by Yang on 2020/4/26.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import Foundation

class LoginViewPresenter<View>: LoginPresenter where View: LoginView, View: UIViewController {
    typealias V = View
    
    var mView: View
    
    required init(_ view: View) {
        self.mView = view
    }
    
    func login(_ username: String, _ password: String) {
        guard username.isNotEmpty && password.isNotEmpty else {
            mView.showToast("请输入用户名或密码")
            return
        }
        
        mView.showProgress()
        HttpApis.login(username, password) { [unowned self] in
            self.mView.hideProgress()
            switch $0 {
            case .success(let user):
                User.me.login(user)
                self.mView.loginSuccess()
            case .failure(let msg):
                self.mView.showToast(msg)
            }
        }
    }
}
