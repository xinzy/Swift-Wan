//
//  TestTableViewController.swift
//  Wan
//
//  Created by Yang on 2020/4/26.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit
import MJRefresh

class TestTableViewController: BaseViewController {
    
    private var mKnowledges = [Chapter]()
    
    private lazy var mPresenter: SquareViewPresenter<TestTableViewController> = {
        return SquareViewPresenter(self)
    } ()
    
    private lazy var knowledgeTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(onKnowledgeRefresh))
        tableView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight - 44 - 49 - 20)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.xRegister(SquareKnowledgeTableViewCell.self)
        return tableView
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(knowledgeTableView)
        knowledgeTableView.mj_header?.beginRefreshing()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(screenHeight, knowledgeTableView.height)
    }
}

extension TestTableViewController: SquareView {
    
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
extension TestTableViewController: UITableViewDataSource, UITableViewDelegate {
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
extension TestTableViewController {
    
    /// 导航TableView刷新
    @objc private func onNavigationRefresh() {
        
    }
    
    /// 知识体系TableView刷新
    @objc private func onKnowledgeRefresh() {
        mPresenter.fetchKnowledge()
    }
}

