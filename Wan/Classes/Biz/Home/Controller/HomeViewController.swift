//
//  HomeViewController.swift
//  Wan
//
//  Created by Yang on 2020/4/21.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit
import MJRefresh

class HomeViewController: BaseTableViewController {
    
    private lazy var mBannerView: BannerView = {
        let bannerView = BannerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 192))
        bannerView.delegate = self
        return bannerView
    } ()

    private lazy var mPresenter: HomeViewPresenter<HomeViewController> = {
        return HomeViewPresenter(self)
    }()
    
    
    private var mArticles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.xRegister(ArticleTableViewCell.self)
        self.tableView.tableHeaderView = mBannerView
        
        mRefreshHeader.beginRefreshing()
    }
    
}

// MARK: - View
extension HomeViewController: HomeView {
    
    func showBanner(_ banners: [Banner]) {
        mBannerView.refreshBanner(banners: banners)
    }
    
    func showArticles(_ articles: [Article], _ replace: Bool) {
        if replace {
            mArticles.removeAll()
        }
        mArticles += articles
        self.tableView.reloadData()
    }
}

// MARK: - BannerView Delegate, Refresh Action and Load More Action
extension HomeViewController: BannerViewDelete {
    
    func bannerView(_ bannerView: BannerView, tapIndex: Int, tapBanner: Banner) {
        let controller = WebViewController()
        controller.webTitle = tapBanner.title
        controller.webUrl = tapBanner.url
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func onRefreshAction() {
        mPresenter.refresh()
    }
    
    override func onLoadMoreAction() {
        mPresenter.fetchHomeArticles()
    }
}

// MARK: - Delegate And DataSource
extension HomeViewController {
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
        controller.webTitle = article.displayTitle
        controller.webUrl = article.link
        navigationController?.pushViewController(controller, animated: true)
    }
}
