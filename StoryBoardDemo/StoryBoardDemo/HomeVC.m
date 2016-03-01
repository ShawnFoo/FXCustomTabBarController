//
//  HomeVC.m
//  StoryBoardDemo
//
//  Created by ShawnFoo on 16/3/2.
//  Copyright © 2016年 ShawnFoo. All rights reserved.
//

#import "HomeVC.h"
#import "UITabBarController+FXCustomTabBar.h"

@interface HomeVC ()

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];

    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.navigationController.tabBarItem.fx_tinyBadgeVisible = YES;
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.navigationController.tabBarItem.fx_tinyBadgeVisible = NO;
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.navigationController.tabBarItem.badgeValue = @"1";
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.navigationController.tabBarItem.badgeValue = @"new";
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.navigationController.tabBarItem.badgeValue = nil;
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
