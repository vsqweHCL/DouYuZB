//
//  RecommendViewModel.swift
//  DouYuZB
//
//  Created by HCL黄 on 2016/12/6.
//  Copyright © 2016年 HCL黄. All rights reserved.
//

import UIKit

class RecommendViewModel : BaseViewModel {
    // MARK:- 懒加载属性
//    lazy var anrchorGroups : [AnchorGroup] = [AnchorGroup]()
    fileprivate lazy var bigDataGroup : AnchorGroup = AnchorGroup(dict: ["" : "" as NSObject])
    fileprivate lazy var prettyDataGroup : AnchorGroup = AnchorGroup(dict: ["" : "" as NSObject])
    
    // MARK:- 保存轮播图数组
    lazy var cycleModels : [CycleModel] = [CycleModel]()
}

// MARK:- 发送网络请求
extension RecommendViewModel {
    func requestData(finshCallBack : @escaping ()->()) {
        
        // 创建线程group
        let dis_group = DispatchGroup()
        
        // 1.请求第一部分推荐数据
        dis_group.enter() // 进入线程组
        NetworkTools.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time":NSDate.getCurrentTime()]) { (result) in
            
            // 1 将result转成字典类型
            guard let resultDic = result as? [String : NSObject] else {return}
            
            // 2 根据data该key，获取数组
            guard let dataArray = resultDic["data"] as? [[String : NSObject]] else {return}
            
            // 3 遍历数组，获取字典，并且将字典转成模型对象
            
            // 3.2 设置组的属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            // 3.3 获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            
            
            dis_group.leave() // 离开线程group
            
        }
        
        // 2.请求第二部分颜值数据
        dis_group.enter() // 进入线程组
        NetworkTools.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: ["limit" : "4","offset":"0","time":NSDate.getCurrentTime()]) { (result) in
            
            // 1 将result转成字典类型
            guard let resultDic = result as? [String : NSObject] else {return}
            
            // 2 根据data该key，获取数组
            guard let dataArray = resultDic["data"] as? [[String : NSObject]] else {return}
            
            // 3 遍历数组，获取字典，并且将字典转成模型对象
            
            // 3.2 设置组的属性
            self.prettyDataGroup.tag_name = "颜值"
            self.prettyDataGroup.icon_name = "home_header_phone"
            // 3.3 获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyDataGroup.anchors.append(anchor)
            }
            
            
            dis_group.leave() // 离开线程group
            
        }
        // 3.请求2-12部分游戏数据
        dis_group.enter() // 进入线程组
        loadAnchorData(URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: ["limit" : "4","offset":"0","time":NSDate.getCurrentTime()]) {
            dis_group.leave() // 离开线程group
        }
//        NetworkTools.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: ["limit" : "4","offset":"0","time":NSDate.getCurrentTime()]) { (result) in
//    
//            // 1 将result转成字典类型
//            guard let resultDic = result as? [String : NSObject] else {return}
//            
//            // 2 根据data该key，获取数组
//            guard let dataArray = resultDic["data"] as? [[String : NSObject]] else {return}
//            
//            // 3 遍历数组，获取字典，并且将字典转成模型对象
//            for dict in dataArray {
//                let group = AnchorGroup(dict: dict)
//                self.anchorGroups.append(group)
//            }
//            dis_group.leave() // 离开线程group
        
//            for group in self.anrchorGroups {
//                for anchor in group.anchors {
//                    print(anchor.nickname)
//                }
//            }
//        }
        
        // 所有的数据请求到之后进行排序
        dis_group.notify(queue: DispatchQueue.main, execute: {
            self.anchorGroups.insert(self.prettyDataGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finshCallBack()
        })
    }
    
    
    /// 请求无线轮播的数据
    func requestCycleData(finshCallBack : @escaping ()->()) {
        NetworkTools.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/slide/6", parameters: ["version":"2.300"]) { (result) in
            
            // 1 将result转成字典类型
            guard let resultDic = result as? [String : NSObject] else {return}

            // 2 根据data该key，获取数组
            guard let dataArray = resultDic["data"] as? [[String : NSObject]] else {return}
            
            // 3 字典转模型
            for dict in dataArray {
                self.cycleModels.append(CycleModel(dict: dict))
            }
            
            finshCallBack()
        }
    }
}
