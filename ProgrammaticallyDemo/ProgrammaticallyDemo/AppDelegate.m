//
//  AppDelegate.m
//  ProgrammaticallyDemo
//
//  Created by ShawnFoo on 16/3/8.
//  Copyright © 2016年 ShawnFoo. All rights reserved.
//

#import "AppDelegate.h"
#import "UITabBarController+FXCustomTabBar.h"
#import "HomeVC.h"
#import "SettingVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    self.window = [[UIWindow alloc] initWithFrame:MainScreen.bounds];
    self.window.rootViewController = [self setupTabBarController];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (UITabBarController *)setupTabBarController {
    
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
    return tabBarController;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
