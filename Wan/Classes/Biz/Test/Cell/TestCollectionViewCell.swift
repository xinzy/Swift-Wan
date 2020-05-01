//
//  TestCollectionViewCell.swift
//  Wan
//
//  Created by Yang on 2020/4/30.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit

class TestCollectionViewCell: UICollectionViewCell, CellRegister {
    @IBOutlet weak var nameLabel: UILabel!
    
    var name: String! {
        didSet {
            nameLabel.text = name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nameLabel.widthAnchor.constraint(lessThanOrEqualToConstant: screenWidth - 96).isActive = true
    }

}
