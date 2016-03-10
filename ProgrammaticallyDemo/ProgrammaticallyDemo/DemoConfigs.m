//
//  DemoConfigs.m
//  ProgrammaticallyDemo
//
//  Created by ShawnFoo on 16/3/9.
//  Copyright © 2016年 ShawnFoo. All rights reserved.
//

#import "DemoConfigs.h"
#import "UITabBarController+FXCustomTabBar.h"
#import "HomeVC.h"
#import "SettingVC.h"

@implementation DemoConfigs

+ (UITabBarController *)controllerWithCenterItemAndTitles {
    
    HomeVC *homeVC = [[HomeVC alloc] init];
    UINavigationController *naviHome = [[UINavigationController alloc] initWithRootViewController:homeVC];
    homeVC.title = @"home";
    homeVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"home"
                                                      image:[UIImage imageNamed:@"home"]
                                              selectedImage:[UIImage imageNamed:@"home_selected"]];
    
    UIViewController *calendarVC = [[UIViewController alloc] init];
    UINavigationController *naviCalendar = [[UINavigationController alloc] initWithRootViewController:calendarVC];
    calendarVC.title = @"calendar";
    calendarVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"calendar"
                                                          image:[UIImage imageNamed:@"calendar"]
                                                  selectedImage:[UIImage imageNamed:@"calendar_selected"]];
    
    UIViewController *weatherVC = [[UIViewController alloc] init];
    UINavigationController *naviWeather = [[UINavigationController alloc] initWithRootViewController:weatherVC];
    weatherVC.title = @"weather";
    weatherVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"weather"
                                                         image:[UIImage imageNamed:@"cloud"]
                                                 selectedImage:[UIImage imageNamed:@"cloud_selected"]];
    
    SettingVC *settingVC = [[SettingVC alloc] init];
    UINavigationController *naviSetting = [[UINavigationController alloc] initWithRootViewController:settingVC];
    settingVC.title = @"setting";
    settingVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"setting"
                                                         image:[UIImage imageNamed:@"setting"]
                                                 selectedImage:[UIImage imageNamed:@"setting_selected"]];
    
    // The cycleLife of tabBarController initialized programmatically is a little different from using storyboard.
    // I'm sure you can figure it out by making some break points
    
    // For UITabBarController, viewDidLoad method will finished at this moment
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    // when you set viewControllers, system will also trigger UITabBar's "setItems:animated:" method, to help you setItems
    [tabBarController setViewControllers:@[naviHome, naviCalendar, naviWeather, naviSetting]];
    
    [tabBarController fx_setupCenterItemWithImage:[UIImage imageNamed:@"add"] title:@"add"];
    
    return tabBarController;
}

+ (UITabBarController *)controllerWithCenterItemAndNoTitle {
    
    HomeVC *homeVC = [[HomeVC alloc] init];
    UINavigationController *naviHome = [[UINavigationController alloc] initWithRootViewController:homeVC];
    homeVC.title = @"home";
    homeVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"home"
                                                      image:[UIImage imageNamed:@"home"]
                                              selectedImage:[UIImage imageNamed:@"home_selected"]];
    
    UIViewController *calendarVC = [[UIViewController alloc] init];
    UINavigationController *naviCalendar = [[UINavigationController alloc] initWithRootViewController:calendarVC];
    calendarVC.title = @"calendar";
    calendarVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"calendar"
                                                          image:[UIImage imageNamed:@"calendar"]
                                                  selectedImage:[UIImage imageNamed:@"calendar_selected"]];
    
    UIViewController *weatherVC = [[UIViewController alloc] init];
    UINavigationController *naviWeather = [[UINavigationController alloc] initWithRootViewController:weatherVC];
    weatherVC.title = @"weather";
    weatherVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"weather"
                                                         image:[UIImage imageNamed:@"cloud"]
                                                 selectedImage:[UIImage imageNamed:@"cloud_selected"]];
    
    SettingVC *settingVC = [[SettingVC alloc] init];
    UINavigationController *naviSetting = [[UINavigationController alloc] initWithRootViewController:settingVC];
    settingVC.title = @"setting";
    settingVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"setting"
                                                         image:[UIImage imageNamed:@"setting"]
                                                 selectedImage:[UIImage imageNamed:@"setting_selected"]];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    [tabBarController setViewControllers:@[naviHome, naviCalendar, naviWeather, naviSetting]];
    [tabBarController fx_setupCenterItemWithImage:[UIImage imageNamed:@"add"]];
    
    return tabBarController;
}

+ (UITabBarController *)controllerWithCenterItemAndNoTitles {
    
    HomeVC *homeVC = [[HomeVC alloc] init];
    UINavigationController *naviHome = [[UINavigationController alloc] initWithRootViewController:homeVC];
    homeVC.title = @"home";
    homeVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@""
                                                      image:[UIImage imageNamed:@"home"]
                                              selectedImage:[UIImage imageNamed:@"home_selected"]];
    
    UIViewController *calendarVC = [[UIViewController alloc] init];
    UINavigationController *naviCalendar = [[UINavigationController alloc] initWithRootViewController:calendarVC];
    calendarVC.title = @"calendar";
    calendarVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@""
                                                          image:[UIImage imageNamed:@"calendar"]
                                                  selectedImage:[UIImage imageNamed:@"calendar_selected"]];
    
    UIViewController *weatherVC = [[UIViewController alloc] init];
    UINavigationController *naviWeather = [[UINavigationController alloc] initWithRootViewController:weatherVC];
    weatherVC.title = @"weather";
    weatherVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@""
                                                         image:[UIImage imageNamed:@"cloud"]
                                                 selectedImage:[UIImage imageNamed:@"cloud_selected"]];
    
    SettingVC *settingVC = [[SettingVC alloc] init];
    UINavigationController *naviSetting = [[UINavigationController alloc] initWithRootViewController:settingVC];
    settingVC.title = @"setting";
    settingVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@""
                                                         image:[UIImage imageNamed:@"setting"]
                                                 selectedImage:[UIImage imageNamed:@"setting_selected"]];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    [tabBarController setViewControllers:@[naviHome, naviCalendar, naviWeather, naviSetting]];
    [tabBarController fx_setupCenterItemWithImage:[UIImage imageNamed:@"add"]];
    
    return tabBarController;
}

@end
