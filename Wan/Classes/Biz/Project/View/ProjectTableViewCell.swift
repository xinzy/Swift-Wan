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
    
    @IBOutlet weak var favorBtn: UIButton!
    @IBOutlet weak var loadingImageView: UIImageView!
    var article: Article! {
        didSet {
            coverImageView.kf.setImage(with: URL(string: article.envelopePic))
            authorLabel.text = article.displayAuthor
            categoryBtn.setTitle(article.category, for: .normal)
            titleLabel.text = article.displayTitle
            descLabel.text = article.desc
            timeLabel.text = article.displayTime
            
            favorBtn.isSelected = article.collect
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        favorBtn.addTarget(self, action: #selector(collectClick(_:)), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension ProjectTableViewCell {
    
    /// 收藏按钮点击事件
    @objc private func collectClick(_ sender: UIButton) {
        if self.article.collect {
            uncollect(article.id)
        } else {
            collect(article.id)
        }
    }
    
    private func collect(_ id: Int) {
        favorBtn.isHidden = true
        loadingImageView.isHidden = false
        
        loadingImageView.layer.add(rotationAnimation(), forKey: nil)
        
        HttpApis.collectSelfArticle(id) { [unowned self] in
            self.favorBtn.isHidden = false
            self.loadingImageView.isHidden = true
            switch $0 {
            case .success(_):
                self.article.collect = true
                self.favorBtn.isSelected = true
                
            case .failure(_):
                break
            }
        }
    }
    
    private func uncollect(_ id: Int) {
        favorBtn.isHidden = true
        loadingImageView.isHidden = false
        
        loadingImageView.layer.add(rotationAnimation(), forKey: nil)
        
        HttpApis.collectSelfArticle(id) { [unowned self] in
            self.favorBtn.isHidden = false
            self.loadingImageView.isHidden = true
            switch $0 {
            case .success(_):
                self.article.collect = false
                self.favorBtn.isSelected = false
                
            case .failure(_):
                break
            }
        }
    }
    
    private func rotationAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = Double.pi * 2
        animation.duration = 1
        
        return animation
    }
}
