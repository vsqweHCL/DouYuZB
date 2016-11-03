//
//  HomeViewController.swift
//  DouYuZB
//
//  Created by HCL黄 on 16/11/3.
//  Copyright © 2016年 HCL黄. All rights reserved.
//

import UIKit

private let kTitleViewH: CGFloat = 40

class HomeViewController: UIViewController {

    // MARK:- 懒加载属性
    private lazy var pageTitleView: PageTitleView = {
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        
        return titleView
    }()
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置UI界面
        setupUI()
    }
}

extension HomeViewController {

    private func setupUI() {
        // 0.不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        // 1.设置导航栏
        setupNavigationBar()
        
        // 2.添加TitleView
        view.addSubview(pageTitleView)
    }
    
    private func setupNavigationBar() {
        // 1.设置左侧的Item
        let btn = UIButton()
        btn.setImage(UIImage(named: "logo"), forState: .Normal)
        btn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
    
        // 2.设置右侧的Item
        let size = CGSizeMake(40, 40)
        let historyItem = UIBarButtonItem.createItem("image_my_history", highImageName: "Image_my_history_click", size: size)
        
        let searchItem = UIBarButtonItem.createItem("btn_search", highImageName: "btn_search_clicked", size: size)
        
//        let qrcodeItem = UIBarButtonItem.createItem("Image_scan", highImageName: "Image_scan_click", size: size)
        // 构造函数
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem,qrcodeItem]
        
        
    }
    
    
    
}