//
//  ProjectViewPresenter.swift
//  Wan
//
//  Created by Yang on 2020/4/24.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import Foundation

class ProjectViewPresenter<View>: ProjectPresenter where View: ProjectView, View: UIViewController  {
    typealias V = View
    
    var mView: View
    
    required init(_ view: View) {
        self.mView = view
    }
    
    func fetchChapters() {
        self.mView.showProgress()
        
        HttpApis.loadProjectChapter { [unowned self] result in
            self.mView.hideProgress()
            switch result {
            case .success(let chapters):
                self.mView.setupTabs(chapters)
                
            case .failure(let msg):
                self.mView.showToast(msg)
            }
        }
    }
    
}
