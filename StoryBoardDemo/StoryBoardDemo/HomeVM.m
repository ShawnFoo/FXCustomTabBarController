//
//  HomeVM.m
//  StoryBoardDemo
//
//  Created by ShawnFoo on 16/3/2.
//  Copyright © 2016年 ShawnFoo. All rights reserved.
//

#import "HomeVM.h"

NSString *const HomeVM_TitleKey = @"HomeVM_TitleKey";
NSString *const HomeVM_ActionNameKey = @"HomeVM_ActionNameKey";

@interface HomeVM ()

@property (readonly, nonatomic) NSArray *models;

@end

@implementation HomeVM

- (NSArray *)models {
    
    return @[
             @{
                 HomeVM_TitleKey: @"PresentBadge",
                 HomeVM_ActionNameKey: @"presentBadge"
                 },
             @{
                 HomeVM_TitleKey: @"DismissBadge",
                 HomeVM_ActionNameKey: @"dismissBadge"
                 },
             @{
                 HomeVM_TitleKey: @"PresentTinyBadge",
                 HomeVM_ActionNameKey: @"presentTinyBadge"
                 },
             @{
                 HomeVM_TitleKey: @"DismissTinyBadge",
                 HomeVM_ActionNameKey: @"dismissTinyBadge"
                 },
             @{
                 HomeVM_TitleKey: @"ChangeSelectedViewController",
                 HomeVM_ActionNameKey: @"changeSelectedViewController"
                 },
             @{
                 HomeVM_TitleKey: @"ChangeSelectedIndex",
                 HomeVM_ActionNameKey: @"changeSelectedIndex"
                 },
             @{
                 HomeVM_TitleKey: @"CenterItemWithoutTitle",
                 HomeVM_ActionNameKey: @"clearCenterItemTitle"
                 },
             @{
                 HomeVM_TitleKey: @"AllItemsWithoutTitle",
                 HomeVM_ActionNameKey: @"clearAllItemTitle"
                 },
             @{
                 HomeVM_TitleKey: @"TabBarWithBackground",
                 HomeVM_ActionNameKey: @"setupTabBarBackground"
                 },
             @{
                 HomeVM_TitleKey: @"TestReleaseUITabBarController",
                 HomeVM_ActionNameKey: @"releaseUITabBarController"
                 }
             ];
}

- (NSInteger)numOfSections {
    return 1;
}

- (NSInteger)numOfItemsInSection:(NSInteger)section {
    
    if (!section) {
        return self.models.count;
    }
    return 0;
}

- (id)modelAtIndex:(NSInteger)index {
    
    if (index >= 0 && index < self.models.count) {
        return self.models[index];
    }
    return nil;
}

@end
