//
//  GameViewModel.swift
//  DouYuZB
//
//  Created by HCL黄 on 2016/12/20.
//  Copyright © 2016年 HCL黄. All rights reserved.
//

import UIKit

class GameViewModel {
    lazy var games : [GameModel] = [GameModel]()
}

extension GameViewModel {
    func loadAllGameData(finishedCallBack : @escaping () -> ()) {
        NetworkTools.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"]) {(result) in
            
            // 1.获取到数据
            guard let resultDict = result as? [String : Any] else {return}
            guard let dataArray = resultDict["data"] as? [[String : Any]] else {return}
            
            // 2.字典转模型
            for dict in dataArray {
                self.games.append(GameModel(dict: dict))
            }
            
            // 3.回调
            finishedCallBack()
        }
    }
}
