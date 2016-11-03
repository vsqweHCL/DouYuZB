//
//  PageTitleView.swift
//  DouYuZB
//
//  Created by HCL黄 on 16/11/3.
//  Copyright © 2016年 HCL黄. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate : NSObjectProtocol {
    func pageTitleView(titleView: PageTitleView, selectIndex index: Int)
}

private let kScrollLineH: CGFloat = 2

class PageTitleView: UIView {
    // MARK:- 定义代理属性
    weak var delegate: PageTitleViewDelegate?
    
    // MARK: 定义属性
    private var titles: [String]
    
    // MARK:- 记录当前Label的index
    private var currentIndex: Int = 0
    
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

// MARK:- 设置UI界面
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
            
            // 5.给label添加手势
            label.userInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(_:)))
            label.addGestureRecognizer(tapGes)
        }
    }
}

// MARK:- 监听label的点击
extension PageTitleView {
    @objc private func titleLabelClick(tapGes: UITapGestureRecognizer) {
        // 1.获取当前label
        guard let currentLabel = tapGes.view as? UILabel else {return}
        
        // 2.获取之前的label
        let oldLabel = titleLabels[currentIndex]
        
        // 3.切换文字的颜色
        currentLabel.textColor = UIColor.orangeColor()
        oldLabel.textColor = UIColor.darkGrayColor()
        
        // 4.保存最新label的下标值
        currentIndex = currentLabel.tag
        
        // 5.滚动条位置发生改变
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animateWithDuration(0.25) { 
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        // 6.通知代理
        delegate?.pageTitleView(self, selectIndex: currentIndex)
    }
}

// MARK:- 对外暴露方法
extension PageTitleView {
    func setTitleWithProgess(progess: CGFloat, sourceIndex: Int, targetIndex: Int) {
        
    }
}