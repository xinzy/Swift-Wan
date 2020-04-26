//
//  SquareViewController.swift
//  Wan
//
//  Created by Yang on 2020/4/25.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit
import MJRefresh

class SquareViewController: BaseViewController, NibLoadable {
    @IBOutlet weak var pagerTab: PagerTab!
    @IBOutlet weak var scrollView: UIScrollView!
    
    private lazy var mPresenter: SquareViewPresenter<SquareViewController> = {
        return SquareViewPresenter(self)
    } ()
    
    private lazy var knowledgeTableView: UITableView = {
        let tableView = UITableView()
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(onKnowledgeRefresh))
        header.lastUpdatedTimeLabel?.isHidden = true
        tableView.separatorStyle = .none
        tableView.mj_header = header
        tableView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: self.scrollView.contentSize.height)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.xRegister(SquareKnowledgeTableViewCell.self)
        return tableView
    } ()
    
    private lazy var navigationTableView: UITableView = {
        let tableView = UITableView()
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(onNavigationRefresh))
        header.lastUpdatedTimeLabel?.isHidden = true
        tableView.separatorStyle = .none
        tableView.mj_header = header
        tableView.frame = CGRect(x: screenWidth, y: 0, width: screenWidth, height: self.scrollView.height)
        
        return tableView
    } ()
    
    private var mKnowledges = [Chapter]()
    override func viewDidLoad() {
        super.viewDidLoad()

        pagerTab.delegate = self
        let h = screenHeight - statusBarHeight - safeAreaBottom - 44 - 49
        scrollView.contentSize = CGSize(width: screenWidth * 2, height: h)
        scrollView.isScrollEnabled = false
        scrollView.addSubview(knowledgeTableView)
        scrollView.addSubview(navigationTableView)
        
        knowledgeTableView.mj_header?.beginRefreshing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

extension SquareViewController: SquareView {
    
    func showKnowledges(_ knowledges: [Chapter]) {
        mKnowledges.removeAll()
        mKnowledges += knowledges
        knowledgeTableView.reloadData()
    }
    
    func endRefreshKnowledge() {
        knowledgeTableView.mj_header?.endRefreshing()
    }
}

//MARK: - DataSource And Delegate
extension SquareViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == knowledgeTableView {
            return mKnowledges.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == knowledgeTableView {
            let cell = tableView.xDequeueReusableCell(indexPath) as SquareKnowledgeTableViewCell
            cell.chapter = mKnowledges[indexPath.row]
            return cell
        }
        
        return UITableViewCell()
    }
}

//MARK: - Refresh Target
extension SquareViewController {
    
    /// 导航TableView刷新
    @objc private func onNavigationRefresh() {
        
    }
    
    /// 知识体系TableView刷新
    @objc private func onKnowledgeRefresh() {
        mPresenter.fetchKnowledge()
    }
}

//MARK: - PagerTab Delegate
extension SquareViewController: PagerTabDelegate {
    func pagerTab(_ tab: PagerTab, toIndex index: Int, toTitle title: String) {
        scrollView.setContentOffset(CGPoint(x: CGFloat(index) * screenWidth, y: 0), animated: true)
        
        if index == 0 && !mPresenter.isKnowledgeLoaded {
            knowledgeTableView.mj_header?.beginRefreshing()
        } else if index == 1 && !mPresenter.isNavigationLoaded {
            navigationTableView.mj_header?.beginRefreshing()
        }
    }
}
