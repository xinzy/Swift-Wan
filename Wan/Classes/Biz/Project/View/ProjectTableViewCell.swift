//
//  ProjectTableViewCell.swift
//  Wan
//
//  Created by Yang on 2020/4/24.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit

class ProjectTableViewCell: UITableViewCell, CellRegister {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var categoryBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var article: Article! {
        didSet {
            coverImageView.kf.setImage(with: URL(string: article.envelopePic))
            authorLabel.text = article.displayAuthor
            categoryBtn.setTitle(article.category, for: .normal)
            titleLabel.text = article.displayTitle
            descLabel.text = article.desc
            timeLabel.text = article.displayTime
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
