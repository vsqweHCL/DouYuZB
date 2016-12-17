//
//  RecommendViewModel.swift
//  DouYuZB
//
//  Created by HCL黄 on 2016/12/6.
//  Copyright © 2016年 HCL黄. All rights reserved.
//

import UIKit

class RecommendViewModel {
    // MARK:- 懒加载属性
    fileprivate lazy var anrchorGroups : [AnchorGroup] = [AnchorGroup]()
}

// MARK:- 发送网络请求
extension RecommendViewModel {
    func requestData() {
        
        // 1.请求第一部分推荐数据
        
        // 2.请求第二部分颜值数据
        
        // 3.请求后面部分游戏数据
        NetworkTools.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: ["limit" : "4","offset":"0","time":NSDate.getCurrentTime()]) { (result) in
    
            // 1 将result转成字典类型
            guard let resultDic = result as? [String : NSObject] else {return}
            
            // 2 根据data该key，获取数组
            guard let dataArray = resultDic["data"] as? [[String : NSObject]] else {return}
            
            // 3 遍历数组，获取字典，并且将字典转成模型对象
            for dict in dataArray {
                let group = AnchorGroup(dict: dict)
                self.anrchorGroups.append(group)
            }
            
            for group in self.anrchorGroups {
                for anchor in group.anchors {
                    print(anchor.nickname)
                }
            }
        }
    }
}
