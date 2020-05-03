//
//  FavorTableViewCell.swift
//  Wan
//
//  Created by Yang on 2020/5/1.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit

class FavorTableViewCell: UITableViewCell, CellRegister {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var favor: Favor! {
        didSet {
            authorLabel.text = favor.displayAuthor
            titleLabel.text = favor.displayTitle
            descLabel.text = favor.desc
            dateLabel.text = favor.displayTime
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
