//
//  SettingVC.m
//  StoryBoardDemo
//
//  Created by ShawnFoo on 16/3/3.
//  Copyright © 2016年 ShawnFoo. All rights reserved.
//

#import "SettingVC.h"

@implementation SettingVC

- (IBAction)userClickedGoBackHomeBt:(id)sender {
    
    UITabBarController *tabBarController = (UITabBarController *)KeyWindow.rootViewController;
    
    if ([tabBarController isKindOfClass:[UITabBarController class]]) {
        
        NSArray *childVCs = tabBarController.viewControllers;
        id vc = childVCs.firstObject;
        tabBarController.selectedViewController = vc;
    }
}

@end
