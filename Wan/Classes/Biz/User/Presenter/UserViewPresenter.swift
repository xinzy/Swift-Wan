//
//  UserViewPresenter.swift
//  Wan
//
//  Created by Yang on 2020/5/1.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import Foundation

struct UserViewPresenter<View>: UserPresenter where View: UserView, View: UIViewController {
    
    typealias V = View
    var mView: View
    
    init(_ view: View) {
        self.mView = view
    }
    
    func fetchScore() {
        HttpApis.loadMyScore {
            switch $0 {
            case .success(let score):
                self.mView.showScore(score)
            case .failure(_):
                break
            }
        }
    }
}
