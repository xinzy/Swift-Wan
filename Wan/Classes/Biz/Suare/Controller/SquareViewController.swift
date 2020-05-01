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
        let tab = PagerTab(frame: CGRect(x: (screenWidth - 122) / 2, y: 0, width: 122, height: 44))
        tab.backgroundColor = .white
        return tab
    }()
    
    private lazy var mPresenter: SquareViewPresenter<SquareViewController> = {
        return SquareViewPresenter(self)
    } ()
    
    // 知识TableView
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
    
    // 导航主页面
    private lazy var navigationView: UIView = {
        let view = UIView(frame: CGRect(x: screenWidth, y: 0, width: screenWidth, height: self.scrollView.contentSize.height))
        return view
    } ()
    
    // 导航分类TableView
    private lazy var navigationCategoryTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 120, height: self.navigationView.height))
        tableView.showsVerticalScrollIndicator = false
        tableView.xRegister(NavigationCategoryTableViewCell.self)
        tableView.estimatedRowHeight = 44
        
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    // 导航TableView
    private lazy var navigationTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 121, y: 0, width: screenWidth - 121, height: self.navigationView.height))
        
        tableView.xRegister(NavigationTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    } ()
    
    private var mKnowledges = [Chapter]()
    private var mNavis = [Navi]()
    private var mCurrentSelectedRowInNavigationCategory: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.addSubview(pagerTab)
        
        pagerTab.delegate = self
        let h = screenHeight - statusBarHeight - safeAreaBottom - 44 - 49
        scrollView.contentSize = CGSize(width: screenWidth * 2, height: h)
        scrollView.delegate = self
        
        scrollView.addSubview(knowledgeTableView)
        initNavigationView()
        scrollView.addSubview(navigationView)
        
        knowledgeTableView.mj_header?.beginRefreshing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pagerTab.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        pagerTab.isHidden = true
    }
}

//MARK: - View
extension SquareViewController: SquareView {
    
    func showNav(_ navData: [Navi]) {
        mNavis += navData
        navigationCategoryTableView.reloadData()
        navigationCategoryTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .top)
        navigationTableView.reloadData()
        mCurrentSelectedRowInNavigationCategory = 0
    }
    
    func showKnowledges(_ knowledges: [Chapter]) {
        mKnowledges.removeAll()
        mKnowledges += knowledges
        knowledgeTableView.reloadData()
    }
    
    func endRefreshKnowledge() {
        knowledgeTableView.mj_header?.endRefreshing()
    }
    
    private func initNavigationView() {
        let separatorView = UIView(frame: CGRect(x: 120, y: 0, width: 1, height: navigationView.height))
        separatorView.backgroundColor = UIColor(fromHexString: "#F0F0F0")
        navigationView.addSubview(navigationCategoryTableView)
        navigationView.addSubview(navigationTableView)
        navigationView.addSubview(separatorView)
    }
}

//MARK: - DataSource And Delegate
extension SquareViewController: UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, SquareKnowledgeTableViewCellDelegate, NavigationTableViewCellDelete {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == knowledgeTableView {
            return mKnowledges.count
        } else if (tableView == navigationCategoryTableView) {
            return mNavis.count
        } else if (tableView == navigationTableView) {
            return mNavis.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == knowledgeTableView {
            let cell = tableView.xDequeueReusableCell(indexPath) as SquareKnowledgeTableViewCell
            cell.chapter = mKnowledges[indexPath.row]
            cell.delegate = self
            return cell
        } else if tableView == navigationCategoryTableView {
            let cell = tableView.xDequeueReusableCell(indexPath) as NavigationCategoryTableViewCell
            cell.categoryName = mNavis[indexPath.row].name
            return cell
        } else if (tableView == navigationTableView) {
            let cell = tableView.xDequeueReusableCell(indexPath) as NavigationTableViewCell
            cell.nav = mNavis[indexPath.row]
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == knowledgeTableView {
            let controller = KnowledgeArticleViewController()
            controller.chapter = mKnowledges[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        } else if tableView == navigationTableView {
            
        } else if tableView == navigationCategoryTableView {
            mCurrentSelectedRowInNavigationCategory = indexPath.row
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
            navigationTableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
    /// 子知识点击
    func knowledgeCell(_ cell: SquareKnowledgeTableViewCell, subIndex index: Int, chapter knowledge: Chapter) {
        let controller = KnowledgeArticleViewController()
        controller.chapter = knowledge
        controller.subIndex = index
        navigationController?.pushViewController(controller, animated: true)
    }
    
    /// 导航链接点击
    func navigationTableViewCell(_ cell: NavigationTableViewCell, article: Article) {
        let controller = WebViewController()
        controller.webUrl = article.link
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == navigationTableView { //
            let offsetY = scrollView.contentOffset.y
            
            if offsetY <= 0 {
                mCurrentSelectedRowInNavigationCategory = 0
                navigationCategoryTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .top)
            } else {
                var total: CGFloat = 0
                for (index, nav) in mNavis.enumerated() {
                    let itemHeight = NavigationTableViewCell.itemHeightForKey(key: nav.name)
                    if total + itemHeight > offsetY {
                        if mCurrentSelectedRowInNavigationCategory != index {
                            mCurrentSelectedRowInNavigationCategory = index
                            navigationCategoryTableView.selectRow(at: IndexPath(row: index, section: 0), animated: true, scrollPosition: .top)
                        }
                        break
                    } else {
                        total += itemHeight
                    }
                }
            }
        }
    }
    
    /// 检查ScrollView 滑动结束时位置
    private func checkScrollViewIndex(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / screenWidth)
        pagerTab.setSelectedIndex(index)
    }
}

//MARK: - Refresh Target
extension SquareViewController {
    
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
            showProgress()
            perform(#selector(loadNavigationData), with: nil, afterDelay: 0.5)
        }
    }
    
    @objc private func loadNavigationData() {
        mPresenter.fetchNavigation()
    }
}
