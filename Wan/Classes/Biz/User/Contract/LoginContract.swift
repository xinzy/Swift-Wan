//
//  LoginContract.swift
//  Wan
//
//  Created by Yang on 2020/4/26.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import Foundation

protocol LoginView: BaseView {
    
    /// 登录成功
    func loginSuccess()
    
}

protocol LoginPresenter: BasePresenter {
    
    /// 登录
    func login(_ username: String, _ password: String)
}
