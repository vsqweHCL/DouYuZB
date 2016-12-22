//
//  AmuseViewController.swift
//  DouYuZB
//
//  Created by HCL黄 on 2016/12/21.
//  Copyright © 2016年 HCL黄. All rights reserved.
//

import UIKit

class AmuseViewController: BaseAnchorViewController {
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.orange
        
    }
}
// MARK:- 请求数据
extension AmuseViewController
{
    override func loadData(){
        // 1.给父类中ViewModel进行赋值
        baseVM = amuseVM
        
        amuseVM.loadAmuseData {
            self.collectionView.reloadData()
        }
    }
}

