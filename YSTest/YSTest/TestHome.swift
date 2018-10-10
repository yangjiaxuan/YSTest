//
//  TestHome.swift
//  Tools
//
//  Created by 杨森 on 2018/8/27.
//  Copyright © 2018年 yangsen. All rights reserved.
//

import UIKit

class TestHome: YSTest {

    override func testDataSourceDictionary() -> [[String : Any]]? {
        return [
            [kSectionTitle   : "简单测试 0",
             kSectionContent : [
                [kItemTitle : "测试 01",kItemSel : "test_01"],
                [kItemTitle : "测试 02",kItemSel : "test_02"]
                ]
            ],
            [kSectionTitle   : "简单测试 1",
             kSectionContent : [
                [kItemTitle : "测试 11",kItemSel : "test_11"],
                [kItemTitle : "测试 12",kItemSel : "test_12"]
                ]
            ]
        ]
    }
}


extension TestHome{
    
    @objc func test_01(){
        print("测试 01")
    }
    
    @objc func test_02(){
        print("测试 02")
    }
    
    @objc func test_11(){
        print("测试 11")
    }
    
    @objc func test_12(){
        print("测试 12")
    }
}


