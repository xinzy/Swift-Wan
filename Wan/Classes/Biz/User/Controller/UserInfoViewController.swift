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

        nicknameLabel.text = User.me.nickname
    }

    @IBAction func logoutClick(_ sender: UIButton) {
        mPresenter.logout()
    }
}

extension UserInfoViewController: UserInfoView {
    
    func logoutSuccess() {
        navigationController?.popViewController(animated: true)
    }
}
