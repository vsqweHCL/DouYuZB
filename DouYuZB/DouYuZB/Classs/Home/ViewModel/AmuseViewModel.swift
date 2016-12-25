//
//  AmuseViewModel.swift
//  DouYuZB
//
//  Created by HCL黄 on 2016/12/22.
//  Copyright © 2016年 HCL黄. All rights reserved.
//

import UIKit

class AmuseViewModel : BaseViewModel {
    
}

extension AmuseViewModel {
    func loadAmuseData(finishedCallBack : @escaping () -> ()) {
        loadAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", parameters: ["shortName" : "game"], finishedCallback: finishedCallBack)
//        NetworkTools.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", parameters: ["shortName" : "game"]) {(result) in
//            
//            // 1.获取到数据
//            guard let resultDict = result as? [String : Any] else {return}
//            guard let dataArray = resultDict["data"] as? [[String : Any]] else {return}
//            
//            // 2.字典转模型
//            for dict in dataArray {
//                self.anchorGroups.append(AnchorGroup(dict: dict))
//            }
//            
//            // 3.回调
//            finishedCallBack()
//        }
    }

    
}
