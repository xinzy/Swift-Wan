//
//  UserInfoContract.swift
//  Wan
//
//  Created by Yang on 2020/4/28.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import Foundation

protocol UserInfoView: BaseView {
    /// 退出登录成功
    func logoutSuccess()
}

protocol UserInfoPresenter: BasePresenter {
    /// 退出登录
    func logout()
}
