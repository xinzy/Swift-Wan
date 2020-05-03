//
//  UserViewController.swift
//  Wan
//
//  Created by Yang on 2020/4/25.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit

class UserViewController: BaseTableViewController {

    private lazy var headerView: UserHeaderView = {
        let headerView = UserHeaderView.loadFromNib()
        headerView.delegate = self
        return headerView
    } ()
    
    private lazy var mPresenter: UserViewPresenter<UserViewController> = {
        return UserViewPresenter(self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let settingButton = UIBarButtonItem(image: UIImage(named: "ic_setting"), style: .plain, target: self, action: #selector(settingClick))
        self.navigationItem.rightBarButtonItem = settingButton
        self.tableView.mj_header?.isHidden = true
        self.tableView.tableHeaderView = headerView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        headerView.user = User.me
        
        if User.me.isLogin {
            mPresenter.fetchScore()
        } else {
            headerView.score = nil
        }
    }
}

//MARK: - DataSource And Delegate
extension UserViewController: UserHeaderViewDelegate {
    
    func headerView(_ headerView: UserHeaderView, action: HeaderViewAction) {
        switch action {
        case .login:
            let controller = LoginViewController()
            navigationController?.pushViewController(controller, animated: true)
        case .info:
            let controller = UserInfoViewController()
            navigationController?.pushViewController(controller, animated: true)
        case .favor:
            let controller = FavorViewController()
            navigationController?.pushViewController(controller, animated: true)
        case .rank:
            let controller = RankViewController()
            navigationController?.pushViewController(controller, animated: true)
        case .score:
            let controller = ScoreHistoryViewController()
            navigationController?.pushViewController(controller, animated: true)
        default:
            let controller = TestCollectionViewController()
            navigationController?.pushViewController(controller, animated: true)
            break
        }
    }
}

//MARK: - View
extension UserViewController: UserView {
    func showScore(_ score: Score) {
        headerView.score = score
    }
    
    @objc private func settingClick() {
    }
}
