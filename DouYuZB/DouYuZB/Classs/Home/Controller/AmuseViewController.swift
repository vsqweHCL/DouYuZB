//
//  AmuseViewController.swift
//  DouYuZB
//
//  Created by HCL黄 on 2016/12/21.
//  Copyright © 2016年 HCL黄. All rights reserved.
//

import UIKit

private let kMenuViewH : CGFloat = 200

class AmuseViewController: BaseAnchorViewController {
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    fileprivate lazy var menuView : AmuseMenuView = {
        let menuView = AmuseMenuView.amuseMenuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        
        return menuView;
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
}

// MARK:- 设置UI界面
extension AmuseViewController {
    override func setupUI() {
        super.setupUI()
        
        // 将菜单的view添加到collectionView中
        collectionView.addSubview(menuView)
        collectionView.contentInset = UIEdgeInsetsMake(kMenuViewH, 0, 0, 0)
    }
}


// MARK:- 请求数据
extension AmuseViewController
{
    override func loadData(){
        // 1.给父类中ViewModel进行赋值
        baseVM = amuseVM
        
        // 2. 请求数据
        amuseVM.loadAmuseData {
            self.collectionView.reloadData()
            
            var tempGroups = self.amuseVM.anchorGroups
            tempGroups.removeFirst()
            self.menuView.groups = tempGroups
            
            self.loadDataFinshed()
        }
    }
}

