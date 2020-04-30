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
    
    @IBOutlet weak var loadingImageView: UIImageView!
    
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
        
        favorBtn.addTarget(self, action: #selector(favorButtonClick(_:)), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

//MARK: - 事件
extension ArticleTableViewCell {
    
    ///点击收藏按钮
    @objc private func favorButtonClick(_ sender: UIButton) {
        guard let article = self.article else { return }
        if article.collect {
            uncollect(article.id)
        } else {
            collect(article.id)
        }
    }
    
    private func collect(_ id: Int) {
        favorBtn.isHidden = true
        favorBtn.isEnabled = false
        loadingImageView.isHidden = false
        let animation = rotationAnimation()
        loadingImageView.layer.add(animation, forKey: nil)
        
        HttpApis.collectSelfArticle(id) { [unowned self] in
            self.favorBtn.isHidden = false
            self.favorBtn.isEnabled = true
            self.loadingImageView.isHidden = true
            
            switch $0 {
            case .success(_):
                self.article!.collect = true
                self.favorBtn.isSelected = true
            case .failure(_):
                break
            }
        }
    }
    
    private func uncollect(_ id: Int) {
        favorBtn.isHidden = true
        favorBtn.isEnabled = false
        loadingImageView.isHidden = false
        
        let animation = rotationAnimation()
        loadingImageView.layer.add(animation, forKey: nil)
//        loadingImageView.layer
        
        HttpApis.uncollectSelfArticle(id) { [unowned self] in
            self.favorBtn.isHidden = false
            self.favorBtn.isEnabled = true
            self.loadingImageView.isHidden = true
            
            switch $0 {
            case .success(_):
                self.article!.collect = false
                self.favorBtn.isSelected = false
            case .failure(_):
                break
            }
        }
    }
    
    private func rotationAnimation() -> CABasicAnimation{
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = Double.pi * 2
        animation.duration = 1
        animation.repeatCount = MAXFLOAT
        return animation
    }
}
