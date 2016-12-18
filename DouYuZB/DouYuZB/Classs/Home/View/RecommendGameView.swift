//
//  RecommendGameView.swift
//  DouYuZB
//
//  Created by HCL黄 on 2016/12/18.
//  Copyright © 2016年 HCL黄. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"
private let kEdgeInsetMargin : CGFloat = 10.0

class RecommendGameView: UIView {
    // MARK:- 定义数据属性
    var groups : [AnchorGroup]? {
        didSet {
            // 先移除前两组数据
            groups?.removeFirst()
            groups?.removeFirst()
            
            // 添加更多
            let moreGroup = AnchorGroup(dict: ["" : "" as NSObject])
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            
            collectionView.reloadData()
        }
    }
    
    // MARK:- 控件属性
    @IBOutlet weak var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing(rawValue: 0)
        
        collectionView.dataSource = self
        //
        collectionView.register(UINib(nibName: "CollectionViewGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        
        // 添加内边距
//        collectionView.contentInset = UIEdgeInsetsMake(0, kEdgeInsetMargin, 0, kEdgeInsetMargin)
    }
}
// MARK:- 遵守UICollectionView的数据源协议
extension RecommendGameView : UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionViewGameCell
        let group = groups![indexPath.item]
        cell.group = group
//        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.orange
        return cell
        
    }
    
}

extension RecommendGameView {
    class func recommendGameView() -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}
