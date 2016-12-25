//
//  AmuseMenuView.swift
//  DouYuZB
//
//  Created by HCL黄 on 2016/12/25.
//  Copyright © 2016年 HCL黄. All rights reserved.
//

import UIKit

private let kMenuCellID = "kMenuCellID"

class AmuseMenuView: UIView {
    
    // MARK:- 定义属性
    var groups : [AnchorGroup]? {
        didSet {
            collectionView.reloadData()
        }
    }

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!

    override func awakeFromNib() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kMenuCellID)
        collectionView.register(UINib(nibName: "AmuseMenuViewCell", bundle: nil), forCellWithReuseIdentifier: kMenuCellID)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }
}

extension AmuseMenuView : UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if groups == nil { return 0 }
        
        let pageNum = (groups!.count - 1) / 8 + 1
        pageControl.numberOfPages = pageNum
        
        return pageNum
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenuCellID, for: indexPath) as! AmuseMenuViewCell

        setupCellDataWith(cell: cell, indexPath: indexPath)
        
        return cell
        
    }
    
    // 给cell设置数据
    private func setupCellDataWith(cell : AmuseMenuViewCell, indexPath : IndexPath) {
        // 0页：0 - 7
        // 1页：8 - 15
        // 2页：16 - 23
        // 1. 取出起始位置和终点位置
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        
        // 2. 判断越界问题
        if endIndex > groups!.count - 1 {
            endIndex = groups!.count - 1
        }
        
        // 3.取出数据，并且赋值给cell
        var temArray = [AnchorGroup]()
        for i in startIndex ... endIndex {
            temArray.append(self.groups![i])
        }
        cell.groups = temArray
//        cell.groups = Array(groups![startIndex...endIndex])
    }
}
extension AmuseMenuView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(collectionView.contentOffset.x / scrollView.bounds.width)
    }
}

extension AmuseMenuView {
    class func amuseMenuView() -> AmuseMenuView {
        return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.first as! AmuseMenuView
    }
}
