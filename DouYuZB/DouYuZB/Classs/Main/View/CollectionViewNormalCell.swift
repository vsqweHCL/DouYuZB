//
//  CollectionViewNormalCell.swift
//  DouYuZB
//
//  Created by HCL黄 on 16/11/17.
//  Copyright © 2016年 HCL黄. All rights reserved.
//

import UIKit

class CollectionViewNormalCell: UICollectionViewCell {

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
            onlineBtn.setTitle(onlineStr, for: UIControlState.normal)
            
            // 显示昵称
            nickNameLabel.text = anchor.nickname
            
            // 设置封面图片
            guard let iconUrl = URL(string: anchor.vertical_src) else {return}
            iconImageView.kf.setImage(with: iconUrl, placeholder: UIImage(named: ""))
            
            // 房间名
            roomNameLabel.text = anchor.room_name
        }
    }

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var roomNameLabel: UILabel!
}
