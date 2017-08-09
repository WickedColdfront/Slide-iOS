//
//  MenuCell.swift
//  Slide for Reddit
//
//  Created by WickedColdfront on 8/7/17.
//  Copyright © 2017 Haptic Apps. All rights reserved.
//
// https://www.youtube.com/watch?v=2kwCfFG5fDA
// https://www.youtube.com/watch?v=PNmuTTd5zWc
// https://www.youtube.com/watch?v=DYsfAD01fYk

import UIKit

class BaseCell: UICollectionViewCell { //i'm not sure why this is necessary
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MenuCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.lightGray : UIColor.white
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
        }
    }
    
    var menuOption: MenuOption? {
        didSet {
            nameLabel.text = menuOption?.name
            if let imageName = menuOption?.imageName {
                iconImageView.image = UIImage(named:imageName)?.withRenderingMode(.alwaysTemplate)
            }

        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Menu Option"
        label.font = FontGenerator.fontOfSize(size: 13, submission: false)
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "test")
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = UIColor.darkGray 

        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        addConstraintsWithFormat(format: "H:|-8-[v0(30)]-8-[v1]|", views: iconImageView, nameLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
        addConstraintsWithFormat(format: "V:[v0(30)]", views: iconImageView)
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    
}
