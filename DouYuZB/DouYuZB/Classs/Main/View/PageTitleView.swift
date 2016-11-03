//
//  PageTitleView.swift
//  DouYuZB
//
//  Created by HCL黄 on 16/11/3.
//  Copyright © 2016年 HCL黄. All rights reserved.
//

import UIKit

private let kScrollLineH: CGFloat = 2

class PageTitleView: UIView {
    
    // MARK: 定义属性
    private var titles: [String]
    
    // MARK:- 懒加载UIScrollView
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    // MARK:- 懒加载ScrollLine
    private lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orangeColor()
        return scrollLine
    }()
    
    // MARK:- 懒加载数组，装Label
    private lazy var titleLabels: [UILabel] = [UILabel]()

    // MARK: 自定义构造函数
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        
        super.init(frame: frame)
        
        // 设置UI界面
        setupUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension PageTitleView {
    private func setupUI(){
        // 1.添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // 2.添加title对应得label
        setupTitleLabel()
        
        // 3.设置底线和滚动的滑块
        setupBottomMenuAndScrollLine()
    }
    
    private func setupBottomMenuAndScrollLine() {
        // 1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGrayColor()
        let lineH: CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        // 2.添加scrollLine
        // 获取第一个label
        guard let firstLabel = titleLabels.first else {return}
        // 默认第一个label显示橘色
        firstLabel.textColor = UIColor.orangeColor()
        
        // 设置scrollLine的属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
        
    }
    
    private func setupTitleLabel(){
        
        let labelW: CGFloat = frame.width / CGFloat(titles.count)
        let labelH: CGFloat = frame.height - kScrollLineH
        let labelY: CGFloat = 0
        
        for (index, title) in titles.enumerate() {
            // 1.创建label
            let label = UILabel()
            
            // 2.设置label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFontOfSize(16.0)
            label.textColor = UIColor.darkGrayColor()
            label.textAlignment = .Center
            
            // 3.将Label的frame
            let labelX: CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            // 4.将label添加到scrollView中
            scrollView.addSubview(label)
            titleLabels.append(label)
            
        }
    }
}
