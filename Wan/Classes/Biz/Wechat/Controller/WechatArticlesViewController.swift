//
//  WechatArticlesViewController.swift
//  Wan
//
//  Created by Yang on 2020/4/23.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit

class WechatArticlesViewController: BaseTableViewController {
    
    private var mArticles: [Article] = [Article]()
    
    private lazy var mPresenter: WechatArticlesViewPresenter<WechatArticlesViewController> = {
        let presenter = WechatArticlesViewPresenter(self)
        presenter.chapter = self.chapter
        return presenter
    } ()
    
    var chapter: Chapter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.xRegister(ArticleTableViewCell.self)
        mRefreshHeader.beginRefreshing()
    }
}

//MARK: - View
extension WechatArticlesViewController: WechatArticlesView {
    func showArticle(_ articles: [Article], _ refresh: Bool) {
        if refresh {
            mArticles.removeAll()
        }
        mArticles += articles
        tableView.reloadData()
    }
    
    func endRefreshFooter() {
        if mRefreshFooter.isRefreshing {
            mRefreshFooter.endRefreshing()
        }
    }
    
    func endRefreshHeader() {
        if mRefreshHeader.isRefreshing {
            mRefreshHeader.endRefreshing()
        }
    }
}

// MARK: - Table view DataSource
extension WechatArticlesViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mArticles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = mArticles[indexPath.row]
        let cell = tableView.xDequeueReusableCell(indexPath) as ArticleTableViewCell
        cell.article = article
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = mArticles[indexPath.row]
        let controller = WebViewController()
        controller.webUrl = article.link
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - LoadMore And Refresh
extension WechatArticlesViewController {
    
    override func onRefreshAction() {
        mPresenter.refresh()
    }
    
    override func onLoadMoreAction() {
        mPresenter.fetchArticles()
    }
}
