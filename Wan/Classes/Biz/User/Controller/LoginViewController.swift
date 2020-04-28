//
//  LoginViewController.swift
//  Wan
//
//  Created by Yang on 2020/4/26.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    private lazy var mPresenter: LoginViewPresenter<LoginViewController> = {
        return LoginViewPresenter(self)
    } ()
    
    private lazy var registerBtn: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(registerClick))
        return btn
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录"
        
        navigationItem.rightBarButtonItem = registerBtn
        loginBtn.addTarget(self, action: #selector(onLogin), for: .touchUpInside)
    }

}

//MARK: - View
extension LoginViewController: LoginView {
    func loginSuccess() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func onLogin() {
        mPresenter.login(usernameField.text ?? "", passwordField.text ?? "")
    }
}

extension LoginViewController {
    @objc private func registerClick() {
        let controller = RegisterViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
