//
//  ScoreHistoryViewController.swift
//  Wan
//
//  Created by Yang on 2020/5/2.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit

class ScoreHistoryViewController: BaseTableViewController {

    private lazy var mPresenter: ScoreHistoryViewPresenter<ScoreHistoryViewController> = {
        return ScoreHistoryViewPresenter(self)
    } ()
    
    private var mHistory: [ScoreHistory] = [ScoreHistory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "积分历史"
        
        tableView.separatorStyle = .singleLine
        tableView.xRegister(ScoreHistoryTableViewCell.self)
        tableView.mj_header?.beginRefreshing()
    }
}

// MARK: - Table view data source
extension ScoreHistoryViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mHistory.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.xDequeueReusableCell(indexPath) as ScoreHistoryTableViewCell
        cell.history = mHistory[indexPath.row]
        return cell
    }
}

extension ScoreHistoryViewController: ScoreHistoryView {
    
    func showScores(_ scores: [ScoreHistory], _ isRefresh: Bool) {
        if isRefresh { mHistory.removeAll() }
        mHistory += scores
        tableView.reloadData()
    }
    
    override func onRefreshAction() {
        mPresenter.refresh()
    }
    
    override func onLoadMoreAction() {
        mPresenter.fetchScoreList()
    }
}
