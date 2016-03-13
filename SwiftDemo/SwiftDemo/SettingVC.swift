//
//  SettingVC.swift
//  SwiftDemo
//
//  Created by ShawnFoo on 16/3/13.
//  Copyright © 2016年 ShawnFoo. All rights reserved.
//

import UIKit

class SettingVC: UIViewController {
    
    @IBAction func userClickedGoBackHomeBt(sender: AnyObject) {
        
        if let tabBarController = KeyWindow?.rootViewController as? UITabBarController,
            let homeVC = tabBarController.viewControllers?.first {
            
            tabBarController.selectedViewController = homeVC
        }
    }
}
