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
    func loadAnchorData(isGroupData : Bool, URLString: String, parameters : [String : Any]? = nil, finishedCallback : @escaping () -> ()) {
        NetworkTools.requestData(type: .GET, urlString: URLString, parameters: parameters!) {(result) in
            
            // 1.获取到数据
            guard let resultDict = result as? [String : Any] else {return}
            guard let dataArray = resultDict["data"] as? [[String : Any]] else {return}
            
            // 2. 判断是否是分组数据
            if isGroupData {
                // 2.1 字典转模型
                for dict in dataArray {
                    self.anchorGroups.append(AnchorGroup(dict: dict))
                }
            }
            else {
                // 2.1 创建组
                let group = AnchorGroup(dict: ["" : ""])
                
                // 2.2 遍历dataArray的所有字典
                for dict in dataArray {
                    group.anchors.append(AnchorModel(dict: dict as! [String : NSObject]))
                }
                
                // 2.3 将group添加到anchorGroups
                self.anchorGroups.append(group)
            }
            
            
            
            // 3.回调
            finishedCallback()
        }

    }
}
