//
//  NSDate-Extension.swift
//  DouYuZB
//
//  Created by HCL黄 on 2016/12/17.
//  Copyright © 2016年 HCL黄. All rights reserved.
//

import Foundation

extension NSDate {
    class func getCurrentTime() -> String {
        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
    
}
