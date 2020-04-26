//
//  ArticleTableViewCell.swift
//  Wan
//
//  Created by Yang on 2020/4/23.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell, CellRegister {
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var categoryBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var newImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var favorBtn: UIButton!
    
    @IBOutlet weak var topImageWidth: NSLayoutConstraint!
    @IBOutlet weak var newImageLeading: NSLayoutConstraint!
    
    var article: Article? {
        didSet {
            guard let art = article else { return }
            
            authorLabel.text = art.displayAuthor
            categoryBtn.setTitle(art.category, for: .normal)
            titleLabel.text = art.displayTitle
            timeLabel.text = art.displayTime
            favorBtn.isSelected = art.collect
            
            if art.top {
                topImageView.isHidden = false
                topImageWidth.constant = 14
            } else {
                topImageView.isHidden = true
                topImageWidth.constant = 0
            }
            
            if art.fresh {
                newImageView.isHidden = false
            } else {
                newImageView.isHidden = true
                if art.top {
                    newImageLeading.constant = 4
                } else {
                    newImageLeading.constant = 0
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
