//
//  HomeVM.h
//  StoryBoardDemo
//
//  Created by ShawnFoo on 16/3/2.
//  Copyright © 2016年 ShawnFoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FXDataSource <NSObject>

@optional

- (id)modelAtIndex:(NSInteger)index;
- (NSInteger)numOfSections;
- (NSInteger)numOfItemsInSection:(NSInteger)section;

@end

extern NSString *const HomeVM_TitleKey;
extern NSString *const HomeVM_ActionNameKey;

@interface HomeVM : NSObject <FXDataSource>

@end
