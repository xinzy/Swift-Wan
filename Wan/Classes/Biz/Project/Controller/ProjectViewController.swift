//
//  ProjectViewController.swift
//  Wan
//
//  Created by Yang on 2020/4/21.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit
import Tabman
import Pageboy

class ProjectViewController: TabmanViewController {

    var mProgressHUD: MBProgressHUD?
    
    private var mChapters: [Chapter] = [Chapter]()
    private var mViewControllers = [Int : UIViewController]()
    
    private lazy var mPresenter: ProjectViewPresenter<ProjectViewController> = {
        return ProjectViewPresenter(self)
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mPresenter.fetchChapters()
    }
    
}

// MARK: - View
extension ProjectViewController: ProjectView {
    
    func setupTabs(_ chapters: [Chapter]) {
        mChapters += chapters
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
extension ProjectViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        mChapters.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        if let controller = mViewControllers[index] {
            return controller
        } else {
            let controller = ProjectListViewController()
            controller.chapter = mChapters[index]
            mViewControllers[index] = controller
            return controller
        }
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        .first
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let chapter = mChapters[index]
        return TMBarItem(title: chapter.displayName)
    }
    
    
}
