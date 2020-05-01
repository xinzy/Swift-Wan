//
//  SquareViewPresenter.swift
//  Wan
//
//  Created by Yang on 2020/4/26.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import Foundation

class SquareViewPresenter<View>: SquarePresenter where View: SquareView, View: UIViewController {
    typealias V = View

    var mView: View
    var isKnowledgeLoaded: Bool { mKnowledgeLoaded }
    var isNavigationLoaded: Bool { mNavigationLoaded }
    
    private var mKnowledgeLoaded = false
    private var mNavigationLoaded = false
    
    required init(_ view: View) {
        self.mView = view
    }
    
    func fetchKnowledge() {
        HttpApis.loadKnowledgeChapter { [unowned self] in
            self.mView.endRefreshKnowledge()
            switch $0 {
            case .success(let chapters):
                self.mKnowledgeLoaded = true
                self.mView.showKnowledges(chapters)
            case.failure(let msg):
                self.mView.showToast(msg)
            }
        }
    }
    
    func fetchNavigation() {
        HttpApis.loadNavi { [unowned self] in
            self.mView.hideProgress()
            
            switch $0 {
            case .success(let navs):
                self.mNavigationLoaded = true
                self.mView.showNav(navs)
            case .failure(let msg):
                self.mView.showToast(msg)
            }
        }
    }
}
