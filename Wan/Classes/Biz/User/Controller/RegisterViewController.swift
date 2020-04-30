//
//  RegisterViewController.swift
//  Wan
//
//  Created by Yang on 2020/4/28.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit

class RegisterViewController: BaseViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmField: UITextField!
    
    @IBOutlet weak var registerBtn: AnimatableButton!
    
    private lazy var mPresenter: RegisterViewPresenter<RegisterViewController> = {
        return RegisterViewPresenter(self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerBtn.addTarget(self, action: #selector(registerClick), for: .touchUpInside)
    }
}

extension RegisterViewController: RegisterView {
    
    func registerSuccess() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func registerClick() {
        mPresenter.register(usernameField.text ?? "", passwordField.text ?? "", confirmField.text ?? "")
    }
}
