//
//  TestCollectionViewController.swift
//  Wan
//
//  Created by Yang on 2020/4/30.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit

class TestCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    private lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlexLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 10
        layout.estimatedItemSize = CGSize(width: 1, height: 24)
        layout.itemSize = UICollectionViewFlexLayout.automaticSize
        
        let view = UICollectionView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight - 39 - 64), collectionViewLayout: layout)
        view.xRegister(TestCollectionViewCell.self)
        view.collectionViewLayout = layout
        
        view.delegate = self
        view.dataSource = self
        return view
    } ()
    
    private let names = [
        "速查 | Android 构建流程",
        "速查 | GitFlow 流程",
        "速查 | 屏幕尺寸和密度 分布屏幕尺寸和密度 分布",
        "速查 | Android 版本分布",
        "测试",
        "哈哈哈",
        "嘻嘻",
        "喔喔",
        "哇哦",
        "你好呀哈哈",
        "你是谁呢",
        "我擦，这就完了",
        "好的",
        "刻印",
        "没毛病",
        "啊",
        "呀哈哈哈",
        "没了",
//        "速查 | Android 混淆流程及产物及产物及产物及产物",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(collectionView)
        
        self.collectionView.xRegister(TestCollectionViewCell.self)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        names.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.xDequeueReusableCell(indexPath) as TestCollectionViewCell
        cell.name = names[indexPath.row]
        return cell
    }
}
