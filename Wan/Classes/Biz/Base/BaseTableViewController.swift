//
//  BaseTableViewController.swift
//  Wan
//
//  Created by Yang on 2020/4/22.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit
import MJRefresh

class BaseTableViewController: UITableViewController {

    lazy var mRefreshHeader: MJRefreshHeader = {
        let header = MJRefreshNormalHeader()
        header.lastUpdatedTimeLabel?.isHidden = true
        return header
    } ()
    lazy var mRefreshFooter: MJRefreshFooter = {
        let footer = MJRefreshAutoNormalFooter()
//        footer.state
        footer.isHidden = true
        return footer
    } ()
    
    var mProgressHUD: MBProgressHUD?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.separatorStyle = .none
        self.tableView.mj_header = mRefreshHeader
        self.tableView.mj_footer = mRefreshFooter
        
        mRefreshHeader.setRefreshingTarget(self, refreshingAction: #selector(onRefreshAction))
        mRefreshFooter.setRefreshingTarget(self, refreshingAction: #selector(onLoadMoreAction))
    }
}

// MARK: - Refresh Action
extension BaseTableViewController {
    @objc func onRefreshAction() {
    }
    
    @objc func onLoadMoreAction() {
    }
}
