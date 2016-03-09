//
//  DemoConfigs.h
//  ProgrammaticallyDemo
//
//  Created by ShawnFoo on 16/3/9.
//  Copyright © 2016年 ShawnFoo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UITabBarController;

@interface DemoConfigs : NSObject

+ (UITabBarController *)controllerWithCenterItemAndTitles;
+ (UITabBarController *)controllerWithCenterItemAndNoTitle;
+ (UITabBarController *)controllerWithCenterItemAndNoTitles;

@end
