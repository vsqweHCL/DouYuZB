//
//  CollectionViewCycleCell.swift
//  DouYuZB
//
//  Created by HCL黄 on 2016/12/18.
//  Copyright © 2016年 HCL黄. All rights reserved.
//

import UIKit

class CollectionViewCycleCell: UICollectionViewCell {

    // MARK:- 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK:- 定义模型数据
    var cycleModel : CycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title

            // 传空字符串有能闪退
//            if let iconURL = URL(string: cycleModel?.tv_pic_url ?? "") {
//                iconImageView.kf.setImage(with: iconURL)
//            }
//            else {
//                iconImageView.image = UIImage(named: "Img_default")
//            }
            
            let iconURL = URL(string: cycleModel?.tv_pic_url ?? "")
            iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "Img_default"))
        }
    }

}
