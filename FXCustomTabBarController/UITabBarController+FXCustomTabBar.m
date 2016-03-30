//
//  UITabBarController+FXCustomTabBar.m
//  CustomCenterItemTabbarDemo
//
//  Created by ShawnFoo on 16/1/20.
//  Copyright © 2016年 ShawnFoo. All rights reserved.
//

#import "UITabBarController+FXCustomTabBar.h"
#import <objc/runtime.h>
#import "FXTabBar.h"
#import "FXTabBarAppearanceConfigs.h"
#import "FXDeallocMonitor.h"

@interface UITabBarController () <FXTabBarDelegate>

@end

@implementation UITabBarController (FXCustomTabBar)

#pragma mark - Hack

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class class = [self class];
        
        FXSwizzleInstanceMethod(class,
                                @selector(viewDidLoad),
                                @selector(fx_viewDidLoad));
        FXSwizzleInstanceMethod(class,
                                @selector(setSelectedViewController:),
                                @selector(fx_setSelectedViewController:));
        FXSwizzleInstanceMethod(class,
                                @selector(setSelectedIndex:),
                                @selector(fx_setSelectedIndex:));
    });
}

#pragma mark - Swizzle Methods

- (void)fx_viewDidLoad {
    [self fx_viewDidLoad];

    [FXDeallocMonitor addMonitorToObj:self];
    [self fx_setupTabBar];
}

- (void)fx_setSelectedViewController:(UIViewController *)selectedViewController {
    [self fx_setSelectedViewController:selectedViewController];
    
    NSInteger selectedIndex = [self.viewControllers indexOfObject:selectedViewController];
    if (NSNotFound != selectedIndex) {
        [self fx_setSelectedItemAtIndex:selectedIndex];
    }
}

- (void)fx_setSelectedIndex:(NSUInteger)selectedIndex {
    [self fx_setSelectedIndex:selectedIndex];
    
    if (selectedIndex < self.viewControllers.count) {
        [self fx_setSelectedItemAtIndex:selectedIndex];
    }
}

- (void)fx_setSelectedItemAtIndex:(NSUInteger)selectedIndex {
    
    FXTabBar *tabBar = (FXTabBar *)self.tabBar;
    if ([tabBar isKindOfClass:[FXTabBar class]]) {
        tabBar.selectedItemIndex = selectedIndex;
    }
}

#pragma mark - Setup CenterItem

- (void)fx_setupCenterItemWithImage:(UIImage *)image {

    [self fx_setupCenterItemWithImage:image highligtedImage:nil title:nil];
}

- (void)fx_setupCenterItemWithImage:(UIImage *)image title:(NSString *)title {
    
    NSParameterAssert(title);
    [self fx_setupCenterItemWithImage:image highligtedImage:nil title:title];
}

- (void)fx_setupCenterItemWithImage:(UIImage *)image highligtedImage:(UIImage *)highlightedImage {
    
    NSParameterAssert(highlightedImage);
    [self fx_setupCenterItemWithImage:image highligtedImage:highlightedImage title:nil];
}

- (void)fx_setupCenterItemWithImage:(UIImage *)image
                    highligtedImage:(UIImage *)highlightedImage
                              title:(NSString *)title {
    
    NSAssert(image, @"image can't be nil!");
    
    UIButton *centerItem;
    UIImage *normalImage = image;
    if (highlightedImage) {
        centerItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [centerItem setImage:highlightedImage forState:UIControlStateHighlighted];
    }
    else {
        centerItem = [UIButton buttonWithType:UIButtonTypeSystem];
        normalImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    [centerItem setImage:normalImage forState:UIControlStateNormal];
    
    if (title.length > 0) {
        centerItem.imageView.contentMode = UIViewContentModeCenter;
        centerItem.titleLabel.textAlignment = NSTextAlignmentCenter;
#ifdef FX_ItemTitleColor
        NSDictionary *attrDic = @{
                                  NSForegroundColorAttributeName: FX_ItemTitleColor
                                  };
        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:title attributes:attrDic];
        [centerItem setAttributedTitle:attrStr forState:UIControlStateNormal];
#else
        [centerItem setTitle:title forState:UIControlStateNormal];
#endif
#ifdef FX_ItemTitleFontSize
        centerItem.titleLabel.font = [UIFont systemFontOfSize:FX_ItemTitleFontSize];
#endif
    }
    
    [FXDeallocMonitor addMonitorToObj:centerItem withDesc:@"centerItem has been deallcated"];
    objc_setAssociatedObject(self, @selector(fx_centerItem), centerItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    FXTabBar *tabBar = (FXTabBar *)self.tabBar;
    if ([tabBar isKindOfClass:[FXTabBar class]]) {
        [tabBar insertCenterItem:centerItem];
    }
}

- (UIButton *)fx_centerItem {
    
    return objc_getAssociatedObject(self, _cmd);
}

#pragma mark CenterItem Action

- (void)fx_setCenterItemClickedEventHandler:(FXEventHandler)handler {

    if (self.fx_centerItem) {
        if (!handler) {
            [self.fx_centerItem removeTarget:self
                                      action:@selector(fx_userClickedCenterItem)
                            forControlEvents:UIControlEventTouchUpInside];
        }
        else {
            [self.fx_centerItem addTarget:self
                                   action:@selector(fx_userClickedCenterItem)
                         forControlEvents:UIControlEventTouchUpInside];
        }
        
        objc_setAssociatedObject(self, @selector(fx_userClickedCenterItem), handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

- (void)fx_userClickedCenterItem {
    
    FXEventHandler handler = objc_getAssociatedObject(self, _cmd);
    if (handler) {
        handler();
    }
}

#pragma mark - Setup TabBar

- (void)fx_setupTabBar {
    
    if (self.fx_centerItem) {
        NSAssert(self.tabBar.items.count%2 == 0, @"The num of tabBarItem(not include centerItem) can't be odd!");
    }
    
    FXTabBar *tabBar = [FXTabBar tabBarWithCenterItem:self.fx_centerItem];
    // KVC: replace the tabBar created by system with custom tabBar
    [self setValue:tabBar forKey:@"tabBar"];
    
#if FX_RemoveTabBarTopShadow
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
#endif
    
    tabBar.fx_delegate = self;
}

#pragma mark - FXTabBarDelegate

- (void)fx_tabBar:(UIView *)tabBar didSelectItemAtIndex:(NSUInteger)index {
    
    if (index < self.viewControllers.count) {
        UIViewController *vc = self.viewControllers[index];
        [self fx_setSelectedViewController:vc];
    }
}

@end

#pragma mark - UITabBarItem + TinyBadge

@implementation UITabBarItem (TinyBadge)

- (void)setFx_tinyBadgeVisible:(BOOL)fx_tinyBadgeVisible {
    if (self.fx_tinyBadgeVisible == fx_tinyBadgeVisible) { return; }
    
    // the properties added by runtime also can be observed by KVO, no need to call willChange、didChange method manually
    objc_setAssociatedObject(self, @selector(fx_tinyBadgeVisible), @(fx_tinyBadgeVisible), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)fx_tinyBadgeVisible {
    NSNumber *value = objc_getAssociatedObject(self, _cmd);
    return value.boolValue;
}

@end
