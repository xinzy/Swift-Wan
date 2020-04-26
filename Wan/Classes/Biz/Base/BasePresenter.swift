//
//  BasePresenter.swift
//  Wan
//
//  Created by Yang on 2020/4/21.
//  Copyright © 2020 Xinzy. All rights reserved.
//

protocol BasePresenter {
    associatedtype V: BaseView
    
    var mView: V { get }
    
    init(_ view: V)
}
