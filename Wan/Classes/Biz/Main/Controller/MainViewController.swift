//
//  MainViewController.swift
//  Wan
//
//  Created by Yang on 2020/4/20.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    private let controllers: [(UIViewController.Type, String, String)] = [
        (HomeViewController.self, "首页", "ic_home"),
        (WechatViewController.self, "公众号", "ic_weixin"),
        (ProjectViewController.self, "项目", "ic_project"),
        (SquareViewController.self, "广场", "ic_square"),
        (UserViewController.self, "我的", "ic_user")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTabBar()
    }

    private func initTabBar() {
        controllers.forEach {
            let controller = $0.0.init()
            controller.tabBarItem.title = $0.1
            controller.title = $0.1
            controller.tabBarItem.image = UIImage(named: $0.2)
            controller.tabBarItem.selectedImage = UIImage(named: "\($0.2)_selected")
            
            controller.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : xDefaultColor], for: .normal)
            controller.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : xSelectedColor], for: .selected)
            
            let navController = MainNavigationController(rootViewController: controller)
            addChild(navController)
        }
    }
}

