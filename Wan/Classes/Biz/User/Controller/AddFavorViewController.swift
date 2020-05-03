//
//  AddFavorViewController.swift
//  Wan
//
//  Created by Yang on 2020/5/1.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit

class AddFavorViewController: BaseViewController {
    static let NOTIFICATION_ADD_FAVOR_SUCCESS: String = "AddFavorSuccessNotification"
    
    @IBOutlet weak var titleTextField: AnimatableTextField!
    @IBOutlet weak var authorTextField: AnimatableTextField!
    @IBOutlet weak var linkTextView: AnimatableTextView!
    
    private lazy var mPresenter: AddFavorViewPresenter<AddFavorViewController> = {
        return AddFavorViewPresenter(self)
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "添加收藏"
        
        let commitBtn = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(commitBtnClick))
        navigationItem.rightBarButtonItems = [commitBtn]
    }
}

//MARK: - View
extension AddFavorViewController: AddFavorView {
    func addSuccess() {
        NotificationCenter.default.post(name: AddFavorViewController.NOTIFICATION_ADD_FAVOR_SUCCESS)
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func commitBtnClick() {
        mPresenter.addFavor(titleTextField.text ?? "", authorTextField.text ?? "", linkTextView.text ?? "")
    }
}
