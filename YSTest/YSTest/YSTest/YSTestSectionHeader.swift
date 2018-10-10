//
//  YSTestSectionHeader.swift
//  Tools
//
//  Created by 杨森 on 2018/8/24.
//  Copyright © 2018年 yangsen. All rights reserved.
//

import UIKit

class YSTestSectionHeader: UICollectionReusableView , YSSetViewHeaderProtocol {
    
    @IBOutlet var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    weak var ys_setView: YSSetView?
    func setHeaderItem(_ cellItem: YSSetItem?) {
        if let cellTitle = cellItem?.cellData as? String {
            titleLabel.text = cellTitle
        }
    }
    
}
