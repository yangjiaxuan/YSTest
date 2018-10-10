//
//  YSSetCell.swift
//  Tools
//
//  Created by 杨森 on 2018/7/20.
//  Copyright © 2018年 yangsen. All rights reserved.
//

import UIKit

class YSSetViewCell : UICollectionViewCell, YSSetViewCellProtocol {
    
    weak var ys_setView : YSSetView?
    
    var cellItem : YSSetItem?
    
    @IBOutlet var titleLabel: UILabel!
    
    func setCellItem(_ cellItem: YSSetItem?) {
        self.cellItem = cellItem
        if let cellData = cellItem?.cellData as? [String : String] {
            titleLabel.text = cellData[kItemTitle]
        }
    }
}
