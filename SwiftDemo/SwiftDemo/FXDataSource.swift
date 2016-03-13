//
//  FXDataSource.swift
//  SwiftDemo
//
//  Created by ShawnFoo on 16/3/13.
//  Copyright © 2016年 ShawnFoo. All rights reserved.
//

import Foundation

protocol FXDataSource {
    
    typealias ModelType
    
    func modelAtIndex(index: Int) -> ModelType?;
    func numOfSections() -> Int;
    func numOfItemsInSection(section: Int) -> Int;
}

extension FXDataSource {
    
    func modelAtIndex(index: Int) -> AnyObject? {
        return nil
    }
    
    func numOfSections() -> Int {
        return 0
    }
    
    func numOfItemsInSection(section: Int) -> Int {
        return 0
    }
}