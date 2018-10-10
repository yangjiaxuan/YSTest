//
//  YSCollectionViewModel.swift
//  Tools
//
//  Created by 杨森 on 2018/7/20.
//  Copyright © 2018年 yangsen. All rights reserved.
//

import Foundation

public class YSSetItem {
    var height = kYSSetView_CellHeight_Default
    var width  = kYSSetView_CellWidth_Default
    var canSelected : Bool  = true
    var identifier : String = ""
    var cellData : Any?
}

public class YSSetSectionItem {
    var marginLeft = 0
    var marginRight = 0
    var marginTop = 0
    var marginBottom = 0
    var minimumLineSpacing = 0
    var minimumInteritemSpacing = 0
    
    var headerItem : YSSetItem?
    var footerItem : YSSetItem?
    var cellItems : [YSSetItem]?
}

public class YSSetViewData {
    var sectionItems : [YSSetSectionItem]?
}


public enum YSSetViewItemActionType {
    case selected // 选择
    case deselected // 反选
    case other  // 其它
}

public protocol YSSetViewDelegate {
    func cellAction(actionType : YSSetViewItemActionType, item : YSSetItem) -> Void
}

public protocol YSSetItemViewDelegate {
    // 视图 使用 weak 修饰
    var ys_setView : YSSetView?{ get set }
}

//MARK: Header
public protocol YSSetViewHeaderProtocol : YSSetItemViewDelegate {
    func setHeaderItem(_ cellItem : YSSetItem?)
}

//MARK: Footer
public protocol YSSetViewFooterProtocol : YSSetItemViewDelegate{
    func setFooterItem(_ cellItem : YSSetItem?)
}

//MARK: Cell
public protocol YSSetViewCellProtocol : YSSetItemViewDelegate{
    func setCellItem(_ cellItem : YSSetItem?)
}







