//
//  SquareKnowledgeTableViewCell2.swift
//  Wan
//
//  Created by Yang on 2020/4/26.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit

protocol SquareKnowledgeTableViewCellDelegate {
    func knowledgeCell(_ cell: SquareKnowledgeTableViewCell, subIndex index: Int, chapter knowledge: Chapter)
}

fileprivate var cachedCollectionHeight = [String : CGFloat]()

class SquareKnowledgeTableViewCell: UITableViewCell, CellRegister {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    var chapter: Chapter! {
        didSet {
            titleLabel.text = chapter.name
            collectionView.reloadData()
            
            collectionViewHeight.constant = heightOfCollectionView(chapter.name)
        }
    }
    var delegate: SquareKnowledgeTableViewCellDelegate?
    
    private let itemSpacing: CGFloat = 5
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        let layout = UICollectionViewFlexLayout()
        layout.minimumLineSpacing = itemSpacing
        layout.minimumInteritemSpacing = itemSpacing
        layout.estimatedItemSize = CGSize(width: 1, height: 24)
        layout.itemSize = UICollectionViewFlexLayout.automaticSize
        
        collectionView.collectionViewLayout = layout
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.xRegister(SquareKnowledgeSubCollectionViewCell.self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

//MARK: - CollectionView DataSource
extension SquareKnowledgeTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        chapter.children.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.xDequeueReusableCell(indexPath) as SquareKnowledgeSubCollectionViewCell
        cell.chapter = self.chapter.children[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.knowledgeCell(self, subIndex: indexPath.row, chapter: chapter)
    }
}

//MARK: - CollectionView 高度
extension SquareKnowledgeTableViewCell {
    private var collectionViewWidth: CGFloat {
        screenWidth - 44
    }
    
    private var collectionViewContentHeight: CGFloat {
        var height: CGFloat = 24
        var offsetX: CGFloat = 0
        let maxWidth = collectionViewWidth
        
        for item in chapter.children {
            let itemWidth = item.name.width(sizeOfSystem: 12) + 32
            
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
        if let height = cachedCollectionHeight[name] {
            return height
        }
        let h = collectionViewContentHeight
        cachedCollectionHeight[name] = h
        return h
    }
}
