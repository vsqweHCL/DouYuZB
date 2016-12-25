//
//  BaseAnchorViewController.swift
//  DouYuZB
//
//  Created by HCL黄 on 2016/12/22.
//  Copyright © 2016年 HCL黄. All rights reserved.
//

import UIKit


private let kItemMargin: CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin) / 2

private let kNormalItemH = kItemW * 3 / 4
private let kPrettyItemH = kItemW * 4 / 3
private let kHeaderViewH: CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kPrettyCellID = "kPrettyCellID"
private let kHeaderViewID = "kHeaderViewID"

class BaseAnchorViewController: BaseViewController {

    // MARK:- 定义属性
    var baseVM : BaseViewModel!
    lazy var collectionView : UICollectionView = {[unowned self] in
        // 1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        // 解决最小间距全部挤到中间
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin)
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
//        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        // 注册
        //        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionViewPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        //        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        
        return collectionView
        }()

    
    // MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadData()
        
    }
    

}
// MARK:- 请求数据
extension BaseAnchorViewController
{
    func loadData(){
    }
}

// MARK:- 设置UI界面内容
extension BaseAnchorViewController
{
    override func setupUI() {
        // 1.给父类中的内容View的引用进行复制
        contentView = collectionView
        
        // 2.将UICollectionView添加到控制器view
        view.addSubview(collectionView)
        
        
        // 如果先调用super的话，内容view是空的
        super.setupUI()
        
    }
}

// MARK:- 遵守UICollectionView的数据源协议
extension BaseAnchorViewController: UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if baseVM == nil { return 1 }
        return baseVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if baseVM == nil { return 20 }
        return baseVM.anchorGroups[section].anchors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionViewNormalCell
        //        cell.backgroundColor = UIColor.randomColor()
        if baseVM == nil {
            return cell
        }
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        return cell
        
        
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        if baseVM == nil {
            return headerView
        }
        headerView.group = baseVM.anchorGroups[indexPath.section]
        return headerView
    }
    
}


// MARK:- 遵守UICollectionView的代理协议
//extension BaseAnchorViewController: UICollectionViewDelegateFlowLayout
//{
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    //    {
    //        if indexPath.section == 1 {
    //            return CGSize(width: kItemW, height: kPrettyItemH)
    //        }
    //        return CGSize(width: kItemW, height: kNormalItemH)
    //    }
//}
