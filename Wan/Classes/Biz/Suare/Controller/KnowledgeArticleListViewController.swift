//
//  KnowledgeArticleListViewController.swift
//  Wan
//
//  Created by Yang on 2020/4/30.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit

class KnowledgeArticleListViewController: BaseTableViewController {
    var chapter: Chapter!
    
    private var mArticles: [Article] = [Article]()
    private lazy var mPresenter: KnowledgeArticleListViewPresenter<KnowledgeArticleListViewController> = {
        let presenter = KnowledgeArticleListViewPresenter(self)
        presenter.chapter = self.chapter
        return presenter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.xRegister(ArticleTableViewCell.self)
        tableView.mj_header?.beginRefreshing()
    }
}

extension KnowledgeArticleListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mArticles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.xDequeueReusableCell(indexPath) as ArticleTableViewCell
        cell.article = mArticles[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = WebViewController()
        controller.webUrl = mArticles[indexPath.row].link
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - View
extension KnowledgeArticleListViewController: KnowledgeArticleListView {
    
    func showArticle(_ articles: [Article], _ refresh: Bool) {
        if refresh {
            mArticles.removeAll()
        }
        mArticles += articles
        tableView.reloadData()
    }
}

//MARK: - Refresh and Load more
extension KnowledgeArticleListViewController {
    override func onRefreshAction() {
        mPresenter.refresh()
    }
    
    override func onLoadMoreAction() {
        mPresenter.fetchArticles()
    }
}

