//
//  CollectionHeaderView.swift
//  DouYuZB
//
//  Created by HCL黄 on 16/11/16.
//  Copyright © 2016年 HCL黄. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    // MARK:- 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK:- 定义模型属性
    var group : AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
    
}
