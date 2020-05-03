//
//  NavigationTableViewCell.swift
//  Wan
//
//  Created by Yang on 2020/4/30.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit

protocol NavigationTableViewCellDelete {
    /// 导航 链接点击
    func navigationTableViewCell(_ cell: NavigationTableViewCell, article: Article)
}

class NavigationTableViewCell: UITableViewCell, CellRegister {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    var nav: Navi! {
        didSet {
            collectionView.reloadData()
            
            collectionViewHeight.constant = heightOfCollectionView(nav.name)
        }
    }
    
    var delegate: NavigationTableViewCellDelete?
    private let itemSpacing: CGFloat = 5
    fileprivate static var cachedCollectionHeight = [String : CGFloat]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        let layout = UICollectionViewFlexLayout()
        layout.minimumLineSpacing = itemSpacing
        layout.minimumInteritemSpacing = itemSpacing
        layout.estimatedItemSize = CGSize(width: 1, height: 24)
        layout.itemSize = UICollectionViewFlexLayout.automaticSize
        
        collectionView.collectionViewLayout = layout
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.xRegister(NavigationItemCollectionViewCell.self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension NavigationTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        nav.articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.xDequeueReusableCell(indexPath) as NavigationItemCollectionViewCell
        cell.name = nav.articles[indexPath.row].title
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.navigationTableViewCell(self, article: nav.articles[indexPath.row])
    }
}

//MARK: - CollectionView 高度
extension NavigationTableViewCell {    
    private var collectionViewWidth: CGFloat {
        screenWidth - 121 - 24
    }
    
    private var collectionViewContentHeight: CGFloat {
        var height: CGFloat = 24
        var offsetX: CGFloat = 0
        let maxWidth = collectionViewWidth
        
        for item in nav.articles {
            let itemWidth = item.title.width(sizeOfSystem: 12) + 32
            
            if offsetX + itemWidth > maxWidth { // 需要换行
                offsetX = itemWidth + itemSpacing
                height += itemSpacing + 24
            } else {
                offsetX += itemSpacing + itemWidth
            }
        }
        return height
    }
    
    /// CollectionView 高度
    private func heightOfCollectionView(_ name: String) -> CGFloat {
        if let height = NavigationTableViewCell.cachedCollectionHeight[name] {
            return height
        }
        let h = collectionViewContentHeight
        NavigationTableViewCell.cachedCollectionHeight[name] = h
        return h
    }
    
    /// 获取缓存的item height
    static func itemHeightForKey(key name: String) -> CGFloat {
        (cachedCollectionHeight[name] ?? 0) + 24
    }
}
