//
//  HomeVC.m
//  StoryBoardDemo
//
//  Created by ShawnFoo on 16/3/2.
//  Copyright © 2016年 ShawnFoo. All rights reserved.
//

#import "HomeVC.h"
#import "HomeVM.h"
#import "UITabBarController+FXCustomTabBar.h"

@interface HomeVC ()

@property (strong, nonatomic) HomeVM *viewModel;

@end

@implementation HomeVC

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewModel = [HomeVM new];
}

#pragma mark - DataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return  [_viewModel numOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_viewModel numOfItemsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *const kCellIndentifier = @"HomeBasicCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIndentifier forIndexPath:indexPath];
    
    NSDictionary *model;
    if ((model = [_viewModel modelAtIndex:indexPath.row])) {
        cell.textLabel.text = model[HomeVM_TitleKey];
    }
   
    return cell;
}

#pragma mark - Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSDictionary *model;
    if ((model = [_viewModel modelAtIndex:indexPath.row])) {
        
        NSString *actionName = model[HomeVM_ActionNameKey];
        SEL actionSEL = NSSelectorFromString(actionName);
        if ([self respondsToSelector:actionSEL]) {
            
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:actionSEL]];
            invocation.target = self;
            invocation.selector = actionSEL;
            
            [invocation invoke];
            //        [invocation getReturnValue:&blabla];
        }
    }
}

#pragma mark - Actions

- (void)presentBadge {
    
    const NSUInteger kMaxNum = 100;
    
    self.navigationController.tabBarItem.badgeValue = @(arc4random()%kMaxNum+1).description;
}

- (void)dismissBadge {
    
    self.navigationController.tabBarItem.badgeValue = nil;
}

- (void)presentTinyBadge {
    
    self.navigationController.tabBarItem.fx_tinyBadgeVisible = YES;
}

- (void)dismissTinyBadge {
    
    self.navigationController.tabBarItem.fx_tinyBadgeVisible = NO;
}

- (void)changeSelectedViewController {
    
    UITabBarController *tabBarController = (UITabBarController *)KeyWindow.rootViewController;
    
    if ([tabBarController isKindOfClass:[UITabBarController class]]) {
        
        NSArray *childVCs = tabBarController.viewControllers;
        id vc = childVCs.lastObject;
        tabBarController.selectedViewController = vc;
    }
}

- (void)changeSelectedIndex {
    
    UITabBarController *tabBarController = (UITabBarController *)KeyWindow.rootViewController;
    
    if ([tabBarController isKindOfClass:[UITabBarController class]]) {
        
        NSArray *childVCs = tabBarController.viewControllers;
        tabBarController.selectedIndex = childVCs.count - 1;
    }
}

@end
