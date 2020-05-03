//
//  UserContract.swift
//  Wan
//
//  Created by Yang on 2020/5/1.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import Foundation

protocol UserView: BaseView {
    /// 展示用户积分
    func showScore(_ score: Score)
}

protocol UserPresenter: BasePresenter {
    /// 获取积分
    func fetchScore()
}
