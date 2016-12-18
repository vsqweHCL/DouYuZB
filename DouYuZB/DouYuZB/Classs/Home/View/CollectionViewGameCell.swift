//
//  CollectionViewGameCell.swift
//  DouYuZB
//
//  Created by HCL黄 on 2016/12/18.
//  Copyright © 2016年 HCL黄. All rights reserved.
//

import UIKit

class CollectionViewGameCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    var group : AnchorGroup? {
        didSet {
            nameLabel.text = group?.tag_name
            
            let iconURL = URL(string: group?.icon_url ?? "")
            iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "推荐常用更多"))
        }
    }

}
