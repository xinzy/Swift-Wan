//
//  WechatViewPresenter.swift
//  Wan
//
//  Created by Yang on 2020/4/23.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import Foundation

class WechatViewPresenter<View>: WechatPresenter where View: WechatView, View: UIViewController {
    typealias V = View
    var mView: View
    
    required init(_ view: View) {
        self.mView = view
    }
    
    func fetchWechat() {
        mView.showProgress()
        
        HttpApis.loadWechats { [unowned self] result in
            self.mView.hideProgress()
            switch result {
            case .success(let tabs):
                self.mView.setupTabs(tabs)
                
            case .failure(let msg):
                self.mView.showToast(msg)
            }
        }
    }
    
}
