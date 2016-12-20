//
//  BaseGameModel.swift
//  DouYuZB
//
//  Created by HCL黄 on 2016/12/20.
//  Copyright © 2016年 HCL黄. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {
    
    // MARK:- 定义属性
    var tag_name : String = ""
    var icon_url : String = ""
    
    // MARK:- 自定义构造函数
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
