//
//  ProjectListViewController.swift
//  Wan
//
//  Created by Yang on 2020/4/24.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit

class ProjectListViewController: BaseTableViewController {

    var chapter: Chapter!
    
    private var mProjects: [Article] = [Article]()
    private lazy var mPresenter: ProjectListViewPresenter<ProjectListViewController> = {
        let presenter = ProjectListViewPresenter<ProjectListViewController>(self)
        presenter.chapter = self.chapter
        return presenter
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.xRegister(ProjectTableViewCell.self)
        beginRefreshHeader()
    }
}

//MARK: - View
extension ProjectListViewController: ProjectListView {
    
    func showProjects(_ list: [Article], _ refresh: Bool) {
        if refresh { mProjects.removeAll() }
        mProjects += list
        self.tableView.reloadData()
    }
    
    override func onRefreshAction() {
        mPresenter.refresh()
    }
    
    override func onLoadMoreAction() {
        mPresenter.fetchProjectList()
    }
}

//MARK: - DataSource And Delegate
extension ProjectListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mProjects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.xDequeueReusableCell(indexPath) as ProjectTableViewCell
        cell.article = mProjects[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = mProjects[indexPath.row]
        let controller = WebViewController()
        controller.webUrl = article.link
        controller.webTitle = article.displayTitle
        navigationController?.pushViewController(controller, animated: true)
    }
}
