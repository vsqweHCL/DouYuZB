//
//  FunnyViewController.swift
//  DouYuZB
//
//  Created by HCL黄 on 2016/12/25.
//  Copyright © 2016年 HCL黄. All rights reserved.
//

import UIKit

private let kTopMargin : CGFloat = 8

class FunnyViewController: BaseAnchorViewController {
    fileprivate lazy var funnyVM : FunnyViewModel = FunnyViewModel()
        

}
extension FunnyViewController {
    override func loadData(){
        // 1.给父类中ViewModel进行赋值
        baseVM = funnyVM

        // 2. 请求数据
        funnyVM.loadFunnyData {
            self.collectionView.reloadData()

        }
    }
}

// MARK:- 设置UI
extension FunnyViewController
{
    override func setupUI() {
        super.setupUI()
        
        // 处理header
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsetsMake(kTopMargin, 0, 0, 0)
    }
}
