//
//  BaseView.swift
//  Wan
//
//  Created by Yang on 2020/4/21.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import MBProgressHUD
import Toast_Swift

protocol BaseView: class {
    var mProgressHUD: MBProgressHUD? { get set }
    
    func showProgress(_ text: String?)
    
    func hideProgress()
    
    func showToast(_ msg: String)
}

extension BaseView where Self: UIViewController {
    
    func showProgress() {
        showProgress(nil)
    }
    
    func showProgress(_ text: String?) {
        mProgressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
        if let labelText = text {
            mProgressHUD?.label.text = labelText
        }
    }
    
    func hideProgress() {
        mProgressHUD?.hide(animated: true)
        mProgressHUD = nil
    }
    
    func showToast(_ msg: String) {
        self.view.makeToast(msg)
    }
}

extension BaseView where Self: UITableViewController {
    
    func beginRefreshHeader() {
        if let header = self.tableView.mj_header, !header.isRefreshing {
            header.beginRefreshing()
        }
    }
    
    func endRefreshHeader() {
        if let header = self.tableView.mj_header, header.isRefreshing {
            header.endRefreshing()
        }
    }
    
    func showRefreshFooter() {
        if let footer = self.tableView.mj_footer, footer.isHidden == true {
            footer.isHidden = false
        }
    }
    
    func setRefreshFooterStatus(_ noMoreData: Bool) {
        if let footer = self.tableView.mj_footer {
            if !noMoreData && footer.state == .noMoreData {
                footer.resetNoMoreData()
            } else if noMoreData && footer.state != .noMoreData {
                footer.endRefreshingWithNoMoreData()
            }
        }
    }
    
    func endLoadMoreFooter() {
        if let footer = self.tableView.mj_footer, footer.isRefreshing {
            footer.endRefreshing()
        }
    }
}
