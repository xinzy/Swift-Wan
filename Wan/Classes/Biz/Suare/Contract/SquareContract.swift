//
//  SquareContract.swift
//  Wan
//
//  Created by Yang on 2020/4/26.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import Foundation

protocol SquareView: BaseView {
    
    func showKnowledges(_ knowledges: [Chapter])
    
    func endRefreshKnowledge()
    
    func showNav(_ navData: [Navi])
}

protocol SquarePresenter: BasePresenter {
    var isKnowledgeLoaded: Bool { get }
    var isNavigationLoaded: Bool { get }
    
    func fetchKnowledge()
    
    func fetchNavigation()
}
