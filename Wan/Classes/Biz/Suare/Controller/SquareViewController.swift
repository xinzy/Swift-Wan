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
    @IBOutlet weak var scrollView: UIScrollView!
    
    private lazy var pagerTab: PagerTab = {
        let tag = PagerTab(frame: CGRect(x: (screenWidth - 122) / 2, y: 0, width: 122, height: 44))
        return tag
    }()
    
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
        
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    } ()
    
    private var mKnowledges = [Chapter]()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.addSubview(pagerTab)
        
        pagerTab.delegate = self
        let h = screenHeight - statusBarHeight - safeAreaBottom - 44 - 49
        scrollView.contentSize = CGSize(width: screenWidth * 2, height: h)
        scrollView.addSubview(knowledgeTableView)
        scrollView.addSubview(navigationTableView)
        scrollView.delegate = self
        
        knowledgeTableView.mj_header?.beginRefreshing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = ""
        pagerTab.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        title = "广场"
        pagerTab.isHidden = true
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
extension SquareViewController: UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, SquareKnowledgeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == knowledgeTableView {
            return mKnowledges.count
        }
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == knowledgeTableView {
            let cell = tableView.xDequeueReusableCell(indexPath) as SquareKnowledgeTableViewCell
            cell.chapter = mKnowledges[indexPath.row]
            cell.delegate = self
            return cell
        }
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
        cell?.textLabel?.text = "\(indexPath.row)"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == knowledgeTableView {
            let controller = KnowledgeArticleViewController()
            controller.chapter = mKnowledges[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        } else if tableView == navigationTableView {
            let controller = UIViewController()
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    /// 子知识点击
    func knowledgeCell(_ cell: SquareKnowledgeTableViewCell, subIndex index: Int, chapter knowledge: Chapter) {
        let controller = KnowledgeArticleViewController()
        controller.chapter = knowledge
        controller.subIndex = index
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            checkScrollViewIndex(scrollView)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == self.scrollView {
            checkScrollViewIndex(scrollView)
        }
    }
    
    /// 检查ScrollView 滑动结束时位置
    private func checkScrollViewIndex(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / screenWidth)
        pagerTab.currentSelectedIndex = index
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
