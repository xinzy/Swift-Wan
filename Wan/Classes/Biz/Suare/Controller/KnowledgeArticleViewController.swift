//
//  KnowledgeArticleViewController.swift
//  Wan
//
//  Created by Yang on 2020/4/29.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit
import Pageboy
import Tabman

class KnowledgeArticleViewController: TabmanViewController {

    var chapter: Chapter!
    var subIndex: Int = 0
    
    private var mViewControllers = [Int : UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = chapter.name

        initTab()
    }

    private func initTab() {
        dataSource = self
        
        let bar = TMBar.ButtonBar()
        bar.indicator.tintColor = xSelectedColor
        bar.layout.transitionStyle = .snap
        bar.layout.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        bar.buttons.customize { btn in
            btn.font = UIFont.systemFont(ofSize: 16)
            btn.tintColor = xDefaultColor
            btn.selectedTintColor = xSelectedColor
        }
        
        addBar(bar, dataSource: self, at: .top)
    }
}

//MARK: - Tab DataSource
extension KnowledgeArticleViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        chapter.children.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        if let controller = mViewControllers[index] {
            return controller
        } else {
            let controller = KnowledgeArticleListViewController()
            mViewControllers[index] = controller
            controller.chapter = chapter.children[index]
            return controller
        }
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        .at(index: subIndex)
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let chapter = self.chapter.children[index]
        return TMBarItem(title: chapter.name)
    }
    
    
}
