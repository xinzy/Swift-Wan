//
//  NavigationCategoryTableViewCell.swift
//  Wan
//
//  Created by Yang on 2020/4/30.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit

class NavigationCategoryTableViewCell: UITableViewCell, CellRegister {
    @IBOutlet weak var categoryLabel: UILabel!
    
    var categoryName: String! {
        didSet {
            categoryLabel.text = categoryName
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            categoryLabel.textColor = xSelectedColor
            contentView.backgroundColor = UIColor(fromHexString: "#F0F0F0")
        } else {
            categoryLabel.textColor = xDefaultColor
            contentView.backgroundColor = .white
        }
    }
    
}
