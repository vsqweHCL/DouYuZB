//
//  CollectionViewPrettyCell.swift
//  DouYuZB
//
//  Created by HCL黄 on 16/11/17.
//  Copyright © 2016年 HCL黄. All rights reserved.
//

import UIKit

class CollectionViewPrettyCell: UICollectionViewCell {
    // MARK:- 定义模型属性
    var anchor : AnchorModel?{
        didSet {
            // 校验模型是否有值
            guard let anchor = anchor else {
                return
            }
            
            // 显示在线人数
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            }
            else {
                onlineStr = "\(anchor.online)万在线"
            }
            onlineLabel.text = onlineStr
            
            // 显示昵称
            nameLabel.text = anchor.nickname
            // 所在城市
            cityBtn.setTitle(anchor.anchor_city, for: UIControlState.normal)
        }
    }
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineLabel: UILabel!
    @IBOutlet weak var cityBtn: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
}
