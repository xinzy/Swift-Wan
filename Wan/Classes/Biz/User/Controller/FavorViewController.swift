//
//  FavorViewController.swift
//  Wan
//
//  Created by Yang on 2020/5/1.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit

class FavorViewController: BaseTableViewController {

    private lazy var mPresenter: FavorViewPresenter<FavorViewController> = {
        return FavorViewPresenter(self)
    } ()
    private var mFavors = [Favor]()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "我的收藏"
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFavorClick))
        navigationItem.rightBarButtonItems = [addBtn]
        
        tableView.xRegister(FavorTableViewCell.self)
        tableView.mj_header?.beginRefreshing()
        
        NotificationCenter.default.addObserver(self, selector: #selector(addFavorCallback), name: NSNotification.Name(rawValue: AddFavorViewController.NOTIFICATION_ADD_FAVOR_SUCCESS), object: nil)
    }
}

// MARK: - Table view data source
extension FavorViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mFavors.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.xDequeueReusableCell(indexPath) as FavorTableViewCell
        cell.favor = mFavors[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = WebViewController()
        controller.webUrl = mFavors[indexPath.row].link
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        mPresenter.uncollect(mFavors[indexPath.row], indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
}

//MARK: - View
extension FavorViewController: FavorView {
    func showFavor(_ favors: [Favor], _ refresh: Bool) {
        if refresh {
            mFavors.removeAll()
        }
        mFavors += favors
        tableView.reloadData()
    }
    
    func uncollectSuccess(_ index: Int) {
        mFavors.remove(at: index)
        tableView.deleteRow(index, 0)
    }
    
    override func onRefreshAction() {
        mPresenter.refresh()
    }
    
    override func onLoadMoreAction() {
        mPresenter.fetchFavor()
    }
    
    @objc private func addFavorClick() {
        let controller = AddFavorViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func addFavorCallback() {
        mPresenter.refresh()
    }
}
