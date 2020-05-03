//
//  UserInfoViewController.swift
//  Wan
//
//  Created by Yang on 2020/4/28.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit

class UserInfoViewController: BaseViewController {
    @IBOutlet weak var nicknameLabel: UILabel!
    
    private lazy var mPresenter: UserInfoViewPresenter<UserInfoViewController> = {
        return UserInfoViewPresenter(self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "个人信息"
        nicknameLabel.text = User.me.nickname
    }

    @IBAction func logoutClick(_ sender: UIButton) {
        let alert = UIAlertController(title: "确定要退出么？", message: "您确定要退出登录么?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "确定", style: .default) { _ in
            self.mPresenter.logout()
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}

//MARK: -View
extension UserInfoViewController: UserInfoView {
    
    func logoutSuccess() {
        navigationController?.popViewController(animated: true)
    }
}
