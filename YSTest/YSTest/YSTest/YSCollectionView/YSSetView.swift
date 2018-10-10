//
//  YSCollectionView.swift
//  Tools
//
//  Created by 杨森 on 2018/7/20.
//  Copyright © 2018年 yangsen. All rights reserved.
//

import UIKit

//MARK: CollectionView
public class YSSetView : UICollectionView{
    private var ys_viewData : YSSetViewData?
    
    public func ys_setViewData(_ viewData_P : YSSetViewData){
        self.ys_viewData = viewData_P
    }
    
    public var ys_viewDelegate : YSSetViewDelegate?
    
    public func ys_itemAction(actionType : YSSetViewItemActionType , item:YSSetItem){
        if let viewDelegate = self.ys_viewDelegate {
            viewDelegate.cellAction(actionType: actionType, item: item)
        }
    }
    
    public class func ys_SettingView(_ frame: CGRect) -> YSSetView {
        let flowLayot = UICollectionViewFlowLayout.init()
        let setView   = YSSetView(frame: frame, collectionViewLayout: flowLayot)
        setView.delegate   = setView
        setView.dataSource = setView
        return setView
    }
    
    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension YSSetView : UICollectionViewDelegateFlowLayout{
    // cell的大小
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellItem = ys_cellItem(indexPath);
        return CGSize.init(width: (cellItem?.width)!, height: (cellItem?.height)!);
    }
    
    // 行距
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let sectionItem = ys_sectionItem(section);
        return CGFloat((sectionItem?.minimumLineSpacing)!);
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        let sectionItem = ys_sectionItem(section);
        return CGFloat((sectionItem?.minimumInteritemSpacing)!);
    }
    
    // 边界
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let sectionItem = ys_sectionItem(section);
        return UIEdgeInsets.init(top: CGFloat((sectionItem?.marginTop)!), left: CGFloat((sectionItem?.marginLeft)!), bottom: CGFloat((sectionItem?.marginBottom)!), right: CGFloat((sectionItem?.marginRight)!));
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        if let headerItem = ys_sectionItem(section)?.headerItem{
            return CGSize.init(width: CGFloat(headerItem.width), height: CGFloat(headerItem.height))
        }else{
            return CGSize.zero
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize{
        if let footerItem = ys_sectionItem(section)?.footerItem{
            return CGSize.init(width: CGFloat(footerItem.width), height: CGFloat(footerItem.height))
        }else{
            return CGSize.zero
        }
    }
}

extension YSSetView : UICollectionViewDataSource{
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: (ys_cellItem(indexPath)?.identifier)!, for: indexPath) as? YSSetViewCellProtocol
        cell?.setCellItem(ys_cellItem(indexPath))
        cell?.ys_setView = self
        return cell as! UICollectionViewCell
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let num = self.ys_viewData?.sectionItems?.count else {
            return 0
        }
        return num
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let num = ys_sectionItem(section)?.cellItems?.count else {
            return 0
        }
        return num
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
        if kind == UICollectionView.elementKindSectionHeader {
            let viewIdentifier = (ys_sectionItem(indexPath.section)?.headerItem?.identifier)!
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: viewIdentifier, for: indexPath) as? YSSetViewHeaderProtocol
            headerView?.setHeaderItem(ys_sectionItem(indexPath.section)?.headerItem)
            return headerView as! UICollectionReusableView
        }else{
            let viewIdentifier = (ys_sectionItem(indexPath.section)?.footerItem?.identifier)!
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: viewIdentifier, for: indexPath) as? YSSetViewFooterProtocol
            footerView?.setFooterItem(ys_sectionItem(indexPath.section)?.footerItem)
            return footerView as! UICollectionReusableView
        }
    }
}

extension YSSetView : UICollectionViewDelegate{
    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let shouldSelected = ys_cellItem(indexPath)?.canSelected else {
            return false
        }
        return shouldSelected
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let viewDelegate = self.ys_viewDelegate,
            let cellItem    = self.ys_cellItem(indexPath){
            viewDelegate.cellAction(actionType: .selected, item: cellItem)
        }
    }
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let viewDelegate = self.ys_viewDelegate,
            let cellItem    = self.ys_cellItem(indexPath){
            viewDelegate.cellAction(actionType: .deselected, item: cellItem)
        }
    }
}

extension YSSetView{
    private func ys_sectionItem(_ section : Int) -> YSSetSectionItem?{
        guard let item = self.ys_viewData?.sectionItems?[section] else {
            return nil
        }
        return item
    }
    func ys_cellItem(_ indexPath : IndexPath) -> YSSetItem? {
        guard let sectionItem = self.ys_viewData?.sectionItems?[indexPath.section] else {
            return nil
        }
        guard let cellItem = sectionItem.cellItems?[indexPath.row] else {
            return nil
        }
        return cellItem
    }
}
