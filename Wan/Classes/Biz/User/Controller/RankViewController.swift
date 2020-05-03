//
//  RankViewController.swift
//  Wan
//
//  Created by Yang on 2020/5/1.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit

class RankViewController: BaseTableViewController {

    private lazy var mPresenter: RankViewPresenter<RankViewController> = {
        return RankViewPresenter(self)
    }()
    
    private var mScores = [Score]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "积分排行"
        
        tableView.mj_header?.beginRefreshing()
        tableView.rowHeight = 64
        tableView.separatorStyle = .singleLine
        tableView.xRegister(RankTableViewCell.self)
    }
    
}

//MARK: - DataSource And Delegate
extension RankViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mScores.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.xDequeueReusableCell(indexPath) as RankTableViewCell
        cell.score = mScores[indexPath.row]
        return cell
    }
}

//MARK: -View
extension RankViewController: RankView {
    
    func showScores(_ scores: [Score], _ refresh: Bool) {
        if refresh { mScores.removeAll() }
        mScores += scores
        tableView.reloadData()
    }
    
    override func onRefreshAction() {
        mPresenter.refresh()
    }
    
    override func onLoadMoreAction() {
        mPresenter.fetchScore()
    }
}
