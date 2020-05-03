//
//  RankTableViewCell.swift
//  Wan
//
//  Created by Yang on 2020/5/1.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit

class RankTableViewCell: UITableViewCell, CellRegister {
    @IBOutlet weak var rankLabel: AnimatableLabel!
    @IBOutlet weak var rankImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var score: Score! {
        didSet {
            usernameLabel.text = score.username
            scoreLabel.text = "\(score.coinCount)"
            let rank = score.rank
            if rank <= 3 {
                rankLabel.isHidden = true
                rankImageView.isHidden = false
                switch rank {
                case 1:
                    rankImageView.image = UIImage(named: "ic_rank_1")
                case 2:
                    rankImageView.image = UIImage(named: "ic_rank_2")
                case 3:
                    rankImageView.image = UIImage(named: "ic_rank_3")
                default:
                    break
                }
            } else {
                rankLabel.isHidden = false
                rankImageView.isHidden = true
                
                if rank < 100 {
                    rankLabel.text = "\(rank)"
                } else {
                    rankLabel.text = "···"
                }
            }
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
