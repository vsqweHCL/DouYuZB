//
//  BaseViewModel.swift
//  DouYuZB
//
//  Created by HCL黄 on 2016/12/22.
//  Copyright © 2016年 HCL黄. All rights reserved.
//

import UIKit

class BaseViewModel {
    var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}

extension BaseViewModel {
    func loadAnchorData(URLString: String, parameters : [String : Any]? = nil, finishedCallback : @escaping () -> ()) {
        NetworkTools.requestData(type: .GET, urlString: URLString, parameters: parameters!) {(result) in
            
            // 1.获取到数据
            guard let resultDict = result as? [String : Any] else {return}
            guard let dataArray = resultDict["data"] as? [[String : Any]] else {return}
            
            // 2.字典转模型
            for dict in dataArray {
                self.anchorGroups.append(AnchorGroup(dict: dict))
            }
            
            // 3.回调
            finishedCallback()
        }

    }
}
