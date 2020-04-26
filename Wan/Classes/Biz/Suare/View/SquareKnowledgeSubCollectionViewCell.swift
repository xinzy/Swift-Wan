//
//  SquareKnowledgeSubCollectionViewCell.swift
//  Wan
//
//  Created by Yang on 2020/4/26.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit

class SquareKnowledgeSubCollectionViewCell: UICollectionViewCell, CellRegister {
    @IBOutlet weak var nameLabel: UILabel!
    
    var chapter: Chapter! {
        didSet {
            nameLabel.text = chapter.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
