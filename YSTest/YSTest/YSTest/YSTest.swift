//
//  YSTest.swift
//  Tools
//
//  Created by 杨森 on 2018/7/20.
//  Copyright © 2018年 yangsen. All rights reserved.
//


import UIKit

class YSTest : UIViewController {
    
    lazy var setView = {()->YSSetView in
        let view = YSSetView.ys_SettingView(UIScreen.main.bounds)
        view.backgroundColor = UIColor.white
        view.register(UINib.init(nibName: kCellIdentigier, bundle: nil), forCellWithReuseIdentifier:kCellIdentigier)
        view.register(UINib.init(nibName:kSectionHeaderIdentigier, bundle: nil), forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader , withReuseIdentifier: kSectionHeaderIdentigier)
        view.ys_setViewData(testDataSorce())
        view.ys_viewDelegate = self;
        return view
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(setView)
    }
    
    
    func testDataSourceDictionary() -> [[String : Any]]?{
        return nil
    }
}

let kSectionTitle : String   = "kSectionTitle"
let kSectionContent : String = "kSectionContent"
let kItemTitle : String      = "kItemTitle"
let kItemSel   : String      = "kItemSel" // 执行的方法

let kCellIdentigier : String          = "YSSetViewCell"
let kSectionHeaderIdentigier : String = "YSTestSectionHeader"

extension YSTest{
    func setTestData(data : [Any]) -> YSSetViewData{
        
        let viewData = YSSetViewData()
        var sections = [YSSetSectionItem]()
        for section in data {
            if let section_P = section as? [String : Any]{
                let section_M = YSSetSectionItem()
                if let section_title = section_P[kSectionTitle] as? String{
                    let sectionHeader        = YSSetItem()
                    sectionHeader.identifier = kSectionHeaderIdentigier
                    sectionHeader.cellData   = section_title
                    section_M.headerItem     = sectionHeader
                }
                if let section_cells = section_P[kSectionContent] as? [[String : Any]]{
                    var cells = [YSSetItem]()
                    for cell in section_cells{
                        let cell_M    = YSSetItem()
                        cell_M.identifier = kCellIdentigier
                        var cell_data = [String : Any]()
                        if let cell_title = cell[kItemTitle] as? String{
                            cell_data[kItemTitle] = cell_title
                        }
                        if let cell_sel   = cell[kItemSel]  as? String{
                            cell_data[kItemSel]  = cell_sel
                        }
                        cell_M.cellData = cell_data
                        cells.append(cell_M)
                    }
                    section_M.cellItems = cells
                }
                sections.append(section_M)
            }
        }
        viewData.sectionItems = sections
        return viewData
    }
    
    func testDataSorce() -> YSSetViewData {
        if let testData = self.testDataSourceDictionary() {
            return self.setTestData(data: testData)
        }else{
            return self.setTestData(data: [])
        }
    }
}

extension YSTest : YSSetViewDelegate{
    
    func cellAction(actionType: YSSetViewItemActionType, item: YSSetItem) {
        if actionType == .selected,
           let cell_sel = (item.cellData as? [String : String])?[kItemSel] {
            
            let sel = Selector(cell_sel)
            self.perform(sel)
        }
    }
    
}
