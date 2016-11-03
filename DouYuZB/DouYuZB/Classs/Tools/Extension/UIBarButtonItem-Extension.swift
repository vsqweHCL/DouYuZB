//
//  UIBarButtonItem-Extension.swift
//  DouYuZB
//
//  Created by HCL黄 on 16/11/3.
//  Copyright © 2016年 HCL黄. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    class func createItem(imageName: String, highImageName: String, size: CGSize) ->UIBarButtonItem {
        
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        btn.setImage(UIImage(named: highImageName), forState: .Highlighted)
        btn.frame = CGRect(origin: CGPointZero, size: size)
        let item = UIBarButtonItem(customView: btn)
        
        return item
    }
    
    // 便利构造函数：1> convenience开头 2>在构造函数中必须明确调用一个设计的构造函数(self)
    // swift语法，可以传默认参数，在下面要做判断
    convenience init(imageName: String, highImageName: String = "", size: CGSize = CGSizeZero) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), forState: .Highlighted)
        }
        
        if size == CGSizeZero {
            btn.sizeToFit()
        }
        else {
            btn.frame = CGRect(origin: CGPointZero, size: size)
        }
        
        self.init(customView: btn)
    }
}