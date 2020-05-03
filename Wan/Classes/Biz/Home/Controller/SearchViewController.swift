//
//  SearchViewController.swift
//  Wan
//
//  Created by Yang on 2020/5/2.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit
import MJRefresh

class SearchViewController: BaseViewController {
    @IBOutlet weak var keywordTextField: UITextField!
    
    @IBOutlet weak var hotkeyCollectionView: UICollectionView!
    @IBOutlet weak var searchResultTableView: UITableView!
    
    private lazy var headerView: MJRefreshNormalHeader = {
        let header = MJRefreshNormalHeader()
        header.lastUpdatedTimeLabel?.isHidden = true
        return header
    }()
    private lazy var footerView: MJRefreshFooter = {
        let footer = MJRefreshAutoNormalFooter {
            self.mPresenter.loadMore()
        }
        footer.isHidden = true
        return footer
    } ()
        
    
    private lazy var hotkeyLayout: UICollectionViewFlexLayout = {
        let layout = UICollectionViewFlexLayout()
        layout.sectionInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 8
        
        layout.estimatedItemSize = CGSize(width: 1, height: 32)
        layout.itemSize = UICollectionViewFlexLayout.automaticSize
        layout.headerReferenceSize = CGSize(width: screenWidth, height: 24)
        
        return layout
    } ()
    
    private lazy var mPresenter: SearchViewPresenter<SearchViewController> = {
        return SearchViewPresenter(self)
    }()
    
    private var mHotKeys = [HotKey]()
    private var mSearchResult = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "搜索"
        
        hotkeyCollectionView.collectionViewLayout = hotkeyLayout
        hotkeyCollectionView.register(HotKeyCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HotKeyCollectionHeaderView")
        hotkeyCollectionView.xRegister(HotKeyCollectionViewCell.self)
        hotkeyCollectionView.dataSource = self
        hotkeyCollectionView.delegate = self
        
        keywordTextField.delegate = self
        keywordTextField.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)
        
        searchResultTableView.xRegister(ArticleTableViewCell.self)
        searchResultTableView.separatorStyle = .none
        searchResultTableView.dataSource = self
        searchResultTableView.delegate = self
        searchResultTableView.mj_header = headerView
        searchResultTableView.mj_footer = footerView
        
        mPresenter.fetchHotKey()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    /// 点击取消按钮
    @IBAction func cancelClick(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - View
extension SearchViewController: SearchView {
    func showHotKeys(_ keys: [HotKey]) {
        mHotKeys.removeAll()
        mHotKeys += keys
        hotkeyCollectionView.reloadData()
    }
    
    func showSearchResult(_ articles: [Article], _ refresh: Bool) {
        if refresh { mSearchResult.removeAll() }
        mSearchResult += articles
        searchResultTableView.reloadData()
    }
    
    func endRefreshHeader() {
        searchResultTableView.mj_header?.endRefreshing()
    }
    
    func endLoadMoreFooter() {
        searchResultTableView.mj_footer?.endRefreshing()
    }
    
    func setFooterViewHidden(_ hidden: Bool) {
        if let footer = self.searchResultTableView.mj_footer, footer.isHidden {
            footer.isHidden = false
        }
    }
    
    func setFooterViewLoadStatus(_ hasNoData: Bool) {
        if let footer = self.searchResultTableView.mj_footer {
           if !hasNoData && footer.state == .noMoreData {
               footer.resetNoMoreData()
           } else if hasNoData && footer.state != .noMoreData {
               footer.endRefreshingWithNoMoreData()
           }
       }
    }
    
    private func search(_ keyword: String) {
        if searchResultTableView.isHidden { searchResultTableView.isHidden = false }
        
        searchResultTableView.mj_footer?.isHidden = true
        searchResultTableView.mj_header?.beginRefreshing {
            self.mPresenter.search(keyword)
        }
    }
}

//MARK: - 搜索热词 CollectionView DataSource And Delegate
extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        mHotKeys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.xDequeueReusableCell(indexPath) as HotKeyCollectionViewCell
        cell.key = mHotKeys[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HotKeyCollectionHeaderView", for: indexPath) as! HotKeyCollectionHeaderView
            return headerView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let key = mHotKeys[indexPath.row]
        keywordTextField.text = key.name
        
        search(key.name)
    }
}

//MARK: - TableView DataSource And Delegate
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mSearchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.xDequeueReusableCell(indexPath) as ArticleTableViewCell
        cell.article = mSearchResult[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = WebViewController()
        controller.webUrl = mSearchResult[indexPath.row].link
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - TextField Delegate
extension SearchViewController: UITextFieldDelegate {
    
    @objc private func textFieldChanged(_ sender: UITextField) {
        guard let input = sender.text?.trimmingCharacters(in: .whitespaces), input.isNotEmpty else {
            mSearchResult.removeAll()
            searchResultTableView.reloadData()
            searchResultTableView.isHidden = true
            return
        }
        search(input)
    }
}
