//
//  HomeVC.swift
//  SwiftDemo
//
//  Created by ShawnFoo on 16/3/13.
//  Copyright © 2016年 ShawnFoo. All rights reserved.
//

import UIKit

// MARK: - Private Contants & ComputedVariable
private let kCellIndentifier = "HomeBasicCell"
private let kFXTabBarControllerID = "FXTabBarController"

// MARK: - HomeVC
class HomeVC: UITableViewController {
    
    private let viewModel = HomeVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
        
        self.tabBarController?.fx_setCenterItemClickedEventHandler({ () -> Void in
            
            self.presentConfirmViewWithTitle("Got it",
                message: "You clicked CenterItem😄",
                confirmButtonTitle: nil,
                cancelButtonTitle: "Well Done",
                confirmHandler: nil,
                cancelHandler: nil)
        })
    }
}

// MARK: - HomeVC + UITableViewDataSource
extension HomeVC {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.viewModel.numOfSections()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numOfItemsInSection(section)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellIndentifier, forIndexPath: indexPath)
        if let model = self.viewModel.modelAtIndex(indexPath.row) {
            cell.textLabel?.text = model[HomeVM_TitleKey]
        }
        
        return cell
    }
}

// MARK: - HomeVC + UITableViewDelegate
extension HomeVC {
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        if let model = self.viewModel.modelAtIndex(indexPath.row),
            let actionName = model[HomeVM_ActionNameKey]
        {
            let actionSEL = Selector(actionName)
            if self.respondsToSelector(actionSEL) {
                self.performSelector(actionSEL)
            }
        }
    }
}

// MARK: - HomeVC + Actions
extension HomeVC {

    @objc private func presentBadge() {
        
        let kMaxNum: UInt32 = 150
        self.navigationController?.tabBarItem.badgeValue = String(arc4random()%kMaxNum + 1)
    }

    @objc private func dismissBadge() {
        
        self.navigationController?.tabBarItem.badgeValue = nil
    }
    
    @objc private func presentTinyBadge() {
        
        self.navigationController?.tabBarItem.fx_tinyBadgeVisible = true
    }
    
    @objc private func dismissTinyBadge() {
        
        self.navigationController?.tabBarItem.fx_tinyBadgeVisible = false
    }
    
    @objc private func changeSelectedViewController() {
        
        if let tabBarController = KeyWindow?.rootViewController as? UITabBarController {
            let lastVC = tabBarController.viewControllers?.last
            tabBarController.selectedViewController = lastVC
        }
    }
    
    @objc private func changeSelectedIndex() {
       
        if let tabBarController = KeyWindow?.rootViewController as? UITabBarController {
            var count = tabBarController.viewControllers?.endIndex ?? 0
            if count != 0 {
                count -= 1
            }
            tabBarController.selectedIndex = count
        }
    }
    
    @objc private func centerItemNoTitle() {
        
        let titleCount = self.tabBarController?.fx_centerItem.titleLabel?.text?.characters.count ?? 0
        if titleCount > 0 {
            if let tabBarController = self.storyboard?.instantiateViewControllerWithIdentifier(kFXTabBarControllerID) as? UITabBarController,
                let image = UIImage(named: "add")
            {
                tabBarController.fx_setupCenterItemWithImage(image)
                KeyWindow?.rootViewController = nil
                dispatch_after(dispatch_time_t(UInt64(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), { () -> Void in
                    KeyWindow?.rootViewController = tabBarController
                })
            }
        }
    }
    
    @objc private func allItemsNoTitle() {
        
        let titleCount = self.navigationController?.tabBarItem.title?.characters.count ?? 0
        if titleCount > 0 {
            if let tabBarController = self.storyboard?.instantiateViewControllerWithIdentifier(kFXTabBarControllerID) as? UITabBarController,
                let image = UIImage(named: "add"),
                let childs = tabBarController.viewControllers
            {
                tabBarController.fx_setupCenterItemWithImage(image)
                for vc in childs {
                    vc.tabBarItem.title = nil
                }
                KeyWindow?.rootViewController = tabBarController
            }
        }
    }
    
    @objc private func setTabBarBackground() {
        
        if self.tabBarController?.tabBar.backgroundImage != nil {
            if let backgroundImage = UIImage(named: "background") {
                self.tabBarController?.tabBar.backgroundImage = backgroundImage
            }
        }
    }
    
    @objc private func releaseUITabBarController() {
        
        self.presentConfirmViewWithTitle("TestRelease",
            message: "You'll see dealloc logs in console.Then a new UITabBarController will appear",
            confirmButtonTitle: nil,
            cancelButtonTitle: "Destory All!😈",
            confirmHandler: nil)
            { () -> Void in
                if let tabBarController = self.storyboard?.instantiateViewControllerWithIdentifier(kFXTabBarControllerID) as? UITabBarController,
                    let image = UIImage(named: "add")
                {
                    tabBarController.fx_setupCenterItemWithImage(image, title: "add")
                    
                    // In iOS7, If we show an alertView, then current topWindow is one of the windows system created for UIAlertView since its level is UIWindowLevelAlert
                    // What amazing is, starting from iOS8.0, we can get normal level window directyly by [UIApplication sharedApplication].keyWindow in same situation
                    // So my guess is the order of releasing alertView's windows are different between iOS7 and iOS8&9
                    print("current topWindow: \(KeyWindow)")
                    
                    for window in ShareApplication.windows {
                        
                        if window.rootViewController is UITabBarController {
                            print("This one is our guy: \(window)")
                            window.rootViewController = tabBarController
                            break
                        }
                    }
                }
            }
    }
}