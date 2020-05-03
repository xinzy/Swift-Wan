//
//  ScoreHistoryTableViewCell.swift
//  Wan
//
//  Created by Yang on 2020/5/2.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit

class ScoreHistoryTableViewCell: UITableViewCell, CellRegister {

    @IBOutlet weak var reasonLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var scoreLabel: AnimatableLabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var history: ScoreHistory! {
        didSet {
            reasonLabel.text = history.reason
            descLabel.text = history.desc
            scoreLabel.text = "\(history.coinCount)"
            timeLabel.text = history.displayTime
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
