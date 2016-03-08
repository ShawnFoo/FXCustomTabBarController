//
//  SettingVC.m
//  StoryBoardDemo
//
//  Created by ShawnFoo on 16/3/3.
//  Copyright © 2016年 ShawnFoo. All rights reserved.
//

#import "SettingVC.h"

@interface SettingVC ()

@property (strong, nonatomic) UIButton *goBackHomeBt;

@end

@implementation SettingVC

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupButton];
}

#pragma mark - UISetup

- (void)setupButton {
    
    if (!_goBackHomeBt) {
        self.goBackHomeBt = [UIButton buttonWithType:UIButtonTypeSystem];
        [_goBackHomeBt setTitle:@"GoBackHome" forState:UIControlStateNormal];
        [_goBackHomeBt addTarget:self action:@selector(userClickedGoBackHomeBt:) forControlEvents:UIControlEventTouchUpInside];
        
        _goBackHomeBt.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:_goBackHomeBt];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_goBackHomeBt attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_goBackHomeBt attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    }
}

#pragma mark - Actions

- (void)userClickedGoBackHomeBt:(id)sender {
    
    UITabBarController *tabBarController = (UITabBarController *)KeyWindow.rootViewController;
    
    if ([tabBarController isKindOfClass:[UITabBarController class]]) {
        
        NSArray *childVCs = tabBarController.viewControllers;
        id vc = childVCs.firstObject;
        tabBarController.selectedViewController = vc;
    }
}

@end
