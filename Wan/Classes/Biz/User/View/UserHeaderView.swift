//
//  UserHeaderView.swift
//  Wan
//
//  Created by Yang on 2020/4/27.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit

protocol UserHeaderViewDelegate {
    
    func headerView(_ headerView: UserHeaderView, action: HeaderViewAction)
}

enum HeaderViewAction {
    case login, info, favor, rank, score, setting
}

class UserHeaderView: UIView, NibLoadable {
    @IBOutlet weak var avatarImageView: AnimatableImageView!
    
    @IBOutlet weak var usernameBtn: UIButton!
    @IBOutlet weak var favorBtn: UIButton!
    @IBOutlet weak var rankBtn: UIButton!
    @IBOutlet weak var scoreBtn: UIButton!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var settingBtn: UIButton!
    var delegate: UserHeaderViewDelegate?
    
    var user: User? {
        didSet {
            guard let user = self.user, user.isLogin else {
                usernameBtn.setTitle("未登录", for: .normal)
                usernameBtn.isSelected = false
                bottomView.isHidden = true
                bottomViewHeight.constant = 0
                self.height = 169 - 56
                layoutIfNeeded()
                return
            }
            usernameBtn.setTitle("欢迎您， \(user.nickname)", for: .normal)
            usernameBtn.isSelected = true
            bottomView.isHidden = false
            bottomViewHeight.constant = 56
            self.height = 169
            
            favorBtn.setTitle("\(user.favorCount + 11)", for: .normal)
            layoutIfNeeded()
        }
    }
    
    override func awakeFromNib() {
        usernameBtn.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        favorBtn.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        rankBtn.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        scoreBtn.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        settingBtn.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
    
        settingBtn.isHidden = true
    }
}

//MARK: - 按钮点击事件
extension UserHeaderView {
    
    @objc private func buttonClick(_ sender: UIButton) {
        guard let delegate = self.delegate else { return }
        if sender == favorBtn {
            delegate.headerView(self, action: .favor)
        } else if sender == rankBtn {
            delegate.headerView(self, action: .rank)
        } else if sender == scoreBtn {
            delegate.headerView(self, action: .score)
        } else if sender == settingBtn {
            delegate.headerView(self, action: .setting)
        } else if sender == usernameBtn {
            if let user = self.user, !user.isLogin {
                delegate.headerView(self, action: .login)
            } else {
                delegate.headerView(self, action: .info)
            }
        }
    }
}
