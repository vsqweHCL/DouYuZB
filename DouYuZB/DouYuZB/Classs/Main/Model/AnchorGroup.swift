//
//  AnchorGroup.swift
//  DouYuZB
//
//  Created by HCL黄 on 2016/12/17.
//  Copyright © 2016年 HCL黄. All rights reserved.
//

import UIKit

class AnchorGroup: BaseGameModel {
    /// 该组中对应的房间信息
    var room_list : [[String : NSObject]]? {
        didSet { // 第二种方法
            guard let room_list = room_list else {return}
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    
    /// 组显示的图标
    var icon_name : String = "home_header_normal"
    
    
    /// 定义主播的模型对象数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()

    
    /*
     第一种方法
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "room_list" {
            if let dataArray = value as? [[String : NSObject]] {
                for dict in dataArray {
                    anchors.append(AnchorModel(dict: dict))
                }
            }
        }
    }
    */
}
