//
//  HotKeyCollectionViewCell.swift
//  Wan
//
//  Created by Yang on 2020/5/2.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit

class HotKeyCollectionViewCell: UICollectionViewCell, CellRegister {
    @IBOutlet weak var keyLabel: UILabel!
    
    var key: HotKey! {
        didSet {
            keyLabel.text = key.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
