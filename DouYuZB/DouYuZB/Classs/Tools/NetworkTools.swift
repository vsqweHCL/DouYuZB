//
//  NetworkTools.swift
//  Alamofire测试版本
//
//  Created by HCL黄 on 2016/12/6.
//  Copyright © 2016年 HCL黄. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

// 删除继承，更加轻量级
class NetworkTools {
    class func requestData(type: MethodType, urlString: String, parameters: [String: Any], finishedCallback: @escaping (_ result : AnyObject) -> ()) {
        // 1. 获取类型
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(urlString, method: method, parameters: parameters).responseJSON { (response) in
            guard let result = response.result.value else {
                print(response.result.error!)
                return
            }
            
            // 回调结果
            finishedCallback(result as AnyObject)
        }
    }
}
