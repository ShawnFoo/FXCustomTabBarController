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
#import "NSObject+FXAlertView.h"

@interface HomeVC ()

@property (strong, nonatomic) HomeVM *viewModel;

@end

@implementation HomeVC

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewModel = [HomeVM new];
    
    // UIViewController: @property(nonatomic, readonly, strong) UITabBarController *tabBarController
    // Although retain cycle did exist here, but it's no need to use weak strong dance here. Before UITabBarController is deallocated, it will break the reference to its child VC(include self), so the retain cycle won't keep. You can clicked TestReleaseUITabBarController cell to test it : ]
    [self.tabBarController fx_setCenterItemClickedEventHandler:^{
        [self presentConfirmViewWithTitle:@"Got it"
                                  message:@"You clicked CenterItem😄"
                       confirmButtonTitle:nil
                        cancelButtonTitle:@"Well Done"
                           confirmHandler:nil
                            cancelHandler:nil];
    }];
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
    
    const NSUInteger kMaxNum = 150;
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

- (void)clearCenterItemTitle {
    
    BOOL hasTitle = self.tabBarController.fx_centerItem.titleLabel.text.length;
    if (hasTitle) {
        
        UITabBarController *tabBarController = [self.storyboard instantiateViewControllerWithIdentifier:@"FXTabBarController"];
        [tabBarController fx_setupCenterItemWithImage:[UIImage imageNamed:@"add"]];
        
        KeyWindow.rootViewController = tabBarController;
    }
}

- (void)clearAllItemTitle {
    
    BOOL hasTitle = self.navigationController.tabBarItem.title.length;
    if (hasTitle) {
        
        UITabBarController *tabBarController = [self.storyboard instantiateViewControllerWithIdentifier:@"FXTabBarController"];
        [tabBarController fx_setupCenterItemWithImage:[UIImage imageNamed:@"add"]];
        for (UIViewController *vc in tabBarController.viewControllers) {
            vc.tabBarItem.title = @"";
        }
        
        KeyWindow.rootViewController = tabBarController;
    }
}

- (void)setupTabBarBackground {

    BOOL hasBackground = self.tabBarController.tabBar.backgroundImage;
    if (!hasBackground) {
        
        UITabBarController *tabBarController = [self.storyboard instantiateViewControllerWithIdentifier:@"FXTabBarController"];
        [tabBarController fx_setupCenterItemWithImage:[UIImage imageNamed:@"add"]];
        [tabBarController fx_setTabBarBackgroundImage:[UIImage imageNamed:@"background"]];
        
        KeyWindow.rootViewController = tabBarController;
    }
}

- (void)releaseUITabBarController {
    
    [self presentConfirmViewWithTitle:@"TestRelease"
                              message:@"You'll see dealloc logs in console.Then a new UITabBarController will appear"
                   confirmButtonTitle:nil
                    cancelButtonTitle:@"Destory All!😈"
                       confirmHandler:nil
                        cancelHandler:^
    {
        UITabBarController *tabBarController = [self.storyboard instantiateViewControllerWithIdentifier:@"FXTabBarController"];
        [tabBarController fx_setupCenterItemWithImage:[UIImage imageNamed:@"add"] title:@"add"];
        
        // In iOS7, If we show an alertView, then current topWindow is one of the windows system created for UIAlertView since its level is UIWindowLevelAlert
        // What amazing is, starting from iOS8.0, we can get normal level window directyly by [UIApplication sharedApplication].keyWindow in same situation
        // So my guess is the order of releasing alertView's windows are different between iOS7 and iOS8&9
        NSLog(@"current topWindow: %@", KeyWindow);
        
        for (UIWindow *window in ShareApplication.windows) {
            // Iterating all windows is a safe way to get normal window from iOS7 to iOS9
            // Or you can check the system version first, then access it by different ways
            if ([window.rootViewController isKindOfClass:[UITabBarController class]]) {
                
                NSLog(@"This one is our guy: %@", window);
                window.rootViewController = tabBarController;
                break;
            }
        }
    }];
}

@end
