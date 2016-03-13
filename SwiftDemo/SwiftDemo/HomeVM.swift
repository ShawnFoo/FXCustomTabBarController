//
//  HomeVM.swift
//  SwiftDemo
//
//  Created by ShawnFoo on 16/3/13.
//  Copyright © 2016年 ShawnFoo. All rights reserved.
//

import Foundation

let HomeVM_TitleKey = "HomeVM_TitleKey"
let HomeVM_ActionNameKey = "HomeVM_ActionNameKey"

struct HomeVM {
    
    private let models = { Void -> [[String: String]] in
        
        return [
            [HomeVM_TitleKey: "PresentBadge",
                HomeVM_ActionNameKey: "presentBadge"],
            [HomeVM_TitleKey: "DismissBadge",
                HomeVM_ActionNameKey: "dismissBadge"],
            [HomeVM_TitleKey: "PresentTinyBadge",
                HomeVM_ActionNameKey: "presentTinyBadge"],
            [HomeVM_TitleKey: "DismissTinyBadge",
                HomeVM_ActionNameKey: "dismissTinyBadge"],
            [HomeVM_TitleKey: "ChangeSelectedViewController",
                HomeVM_ActionNameKey: "changeSelectedViewController"],
            [HomeVM_TitleKey: "ChangeSelectedIndex",
                HomeVM_ActionNameKey: "changeSelectedIndex"],
            [HomeVM_TitleKey: "CenterItemWithoutTitle",
                HomeVM_ActionNameKey: "centerItemNoTitle"],
            [HomeVM_TitleKey: "AllItemsWithoutTitle",
                HomeVM_ActionNameKey: "allItemsNoTitle"],
            [HomeVM_TitleKey: "TestReleaseUITabBarController",
                HomeVM_ActionNameKey: "releaseUITabBarController"],
        ]
    }()
}

extension HomeVM: FXDataSource {
    
    func modelAtIndex(index: Int) -> [String: String]? {

        if index>=0 && index<self.models.count {
            return self.models[index]
        }
        return nil
    }
    
    func numOfSections() -> Int {
        return 1
    }
    
    func numOfItemsInSection(section: Int) -> Int {

        if section == 0 {
            return self.models.count
        }
        return 0
    }
}