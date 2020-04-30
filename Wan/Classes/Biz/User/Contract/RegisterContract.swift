//
//  RegisterContract.swift
//  Wan
//
//  Created by Yang on 2020/4/29.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import Foundation

protocol RegisterView: BaseView {
    
    /// 注册成功
    func registerSuccess()
}

protocol RegisterPresenter: BasePresenter {
    
    /// 注册账号
    func register(_ username: String, _ password: String, _ confirm: String)
}
