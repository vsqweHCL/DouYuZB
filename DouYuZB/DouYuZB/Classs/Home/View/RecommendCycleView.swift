//
//  RecommendCycleView.swift
//  DouYuZB
//
//  Created by HCL黄 on 2016/12/18.
//  Copyright © 2016年 HCL黄. All rights reserved.
//

import UIKit

private let kCycleCellID = "kCycleCellID"

class RecommendCycleView: UIView {
    // MARK:- 懒加载装着CycleModel模型的数组
    var cycleModels : [CycleModel]? {
        didSet {
            // 1. 刷新collectionView
            collectionView.reloadData()
            
            // 2. 设置pageControl的个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
        }
    }
    
    // MARK:- 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing(rawValue: 0)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        // 注册cell
        
        collectionView.register(UINib(nibName: "CollectionViewCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCycleCellID)
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 设置collectionView的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }
}

extension RecommendCycleView {
    class func recommendCycleView() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}
// MARK:- 遵守UICollectionView的数据源协议
extension RecommendCycleView : UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cycleModels?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionViewCycleCell
        let cycleModel = cycleModels![indexPath.item]
        cell.cycleModel = cycleModel
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.orange
        return cell
        
    }

}

// MARK:- 遵守UICollectionView的数据源协议
extension RecommendCycleView : UICollectionViewDelegate
{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 1. 获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        // 2. 计算pageController的currentIndex
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width)
    }
}
