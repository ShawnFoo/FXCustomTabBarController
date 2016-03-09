//
//  FXTabBar.h
//  CustomCenterItemTabbarDemo
//
//  Created by ShawnFoo on 16/2/27.
//  Copyright © 2016年 ShawnFoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FXTabBarDelegate <NSObject>

@optional
- (void)fx_tabBar:(UIView *)tabBar didSelectItemAtIndex:(NSUInteger)index;

@end


@interface FXTabBar : UITabBar

@property (weak, nonatomic) id<FXTabBarDelegate> fx_delegate;
@property (weak, readonly, nonatomic) UIButton *centerItem;
@property (assign, nonatomic) NSUInteger selectedItemIndex;

+ (instancetype)tabBarWithCenterItem:(UIButton *)centerItem;

/**
 *  This method is mainly for initializing UITabBarController programmatically to add centerItem
 *
 *  @param centerItem centerItem
 */
- (void)insertCenterItem:(UIButton *)centerItem;

@end
