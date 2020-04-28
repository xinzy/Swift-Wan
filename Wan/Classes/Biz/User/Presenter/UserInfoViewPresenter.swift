//
//  UserInfoViewPresenter.swift
//  Wan
//
//  Created by Yang on 2020/4/28.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import Foundation

class UserInfoViewPresenter<View>: UserInfoPresenter where View: UserInfoView, View: UIViewController {
    typealias V = View
    
    var mView: View
    
    required init(_ view: View) {
        self.mView = view
    }
    
    func logout() {
        mView.showProgress()
        HttpApis.logout { [unowned self] in
            self.mView.hideProgress()
            switch $0 {
            case .success(_):
                self.mView.logoutSuccess()
                self.mView.showToast("退出登录成功")
                User.me.logout()
                
            case .failure(let msg):
                self.mView.showToast(msg)
            }
        }
    }
}
