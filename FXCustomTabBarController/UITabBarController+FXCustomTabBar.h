//
//  UITabBarController+FXCustomTabBar.h
//  CustomCenterItemTabbarDemo
//
//  Created by ShawnFoo on 16/1/20.
//  Copyright © 2016年 ShawnFoo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FXEventHandler)(void);

@interface UITabBarController (FXCustomTabBar)

@property (strong, readonly, nonatomic) UIButton *fx_centerItem;

/**
 *  set up centerItem
 *
 *  @param image image for UIControlStateNormal
 */
- (void)fx_setupCenterItemWithImage:(UIImage *)image;

/**
 *  set up centerItem
 *
 *  @param image image for UIControlStateNormal
 *  @param title title for IControlStateNormal
 */
- (void)fx_setupCenterItemWithImage:(UIImage *)image title:(NSString *)title;

/**
 *  set up centerItem
 *
 *  @param image            image for UIControlStateNormal
 *  @param highlightedImage image for UIControlStateHighlighted
 */
- (void)fx_setupCenterItemWithImage:(UIImage *)image highligtedImage:(UIImage *)highlightedImage;

/**
 *  set up centerItem
 *
 *  @param image            image for UIControlStateNormal
 *  @param highlightedImage image for UIControlStateHighlighted
 *  @param title            title for IControlStateNormal
 */
- (void)fx_setupCenterItemWithImage:(UIImage *)image highligtedImage:(UIImage *)highlightedImage title:(NSString *)title;

/**
 *  set click action(TouchUpInside) for centerItem. In addition, you could add custom target actions by accessing fx_centerItem
 *
 *  @param handler handler block
 */
- (void)fx_setCenterItemClickedEventHandler:(FXEventHandler)handler;

@end

#pragma mark - UITabBarItem+TinyBadge

@interface UITabBarItem (TinyBadge)

/**
 *  a tiny badge(dot) will appear if you set this property to true/YES. On the contrary, set false to hide tiny badge.
 */
@property (assign, nonatomic) BOOL fx_tinyBadgeVisible;

@end