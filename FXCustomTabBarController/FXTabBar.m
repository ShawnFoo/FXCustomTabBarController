//
//  FXTabBar.m
//  CustomCenterItemTabbarDemo
//
//  Created by ShawnFoo on 16/2/27.
//  Copyright © 2016年 ShawnFoo. All rights reserved.
//

#import "FXTabBar.h"
#import "FXDeallocMonitor.h"
#import "FXTabBarItem.h"
#import "FXTabBarAppearanceConfigs.h"

@interface FXTabBar ()

@property (copy, nonatomic) NSArray *tabbarItems;
@property (weak, nonatomic) UIButton *centerItem;
@property (copy, nonatomic) NSString *centerItemTitle;

@end

@implementation FXTabBar

#pragma mark - Factory

+ (instancetype)tabBarWithItems:(NSArray *)items {
    
    return [self tabBarWithItems:items centerItem:nil];
}

+ (instancetype)tabBarWithItems:(NSArray *)items centerItem:(UIButton *)centerItem {
    
    NSAssert(items.count, @"No Items passed in!");
    
    FXTabBar *tabBar = [[FXTabBar alloc] init];
    tabBar.tabbarItems = items;
    tabBar.centerItem = centerItem;
    [FXDeallocMonitor addMonitorToObj:tabBar];
    
    return tabBar;
}

#pragma mark - Layout

#ifdef FX_TabBarHeight
- (CGSize)sizeThatFits:(CGSize)size {
    
    CGSize newSize = [super sizeThatFits:size];
    newSize.height = FX_TabBarHeight;
    return newSize;
}
#endif

#pragma mark - Setter

- (void)setTabbarItems:(NSArray *)tabbarItems {
    
    if (tabbarItems.count > 0) {
        
        NSMutableArray *temp = [NSMutableArray arrayWithCapacity:tabbarItems.count];
        for (UITabBarItem *item in tabbarItems) {
            if ([item isKindOfClass:[UITabBarItem class]]) {
                
                FXTabBarItem *tabBarItem = [FXTabBarItem itemWithTabbarItem:item];
                
                [tabBarItem addTarget:self action:@selector(userClickedItem:) forControlEvents:UIControlEventTouchUpInside];
                [temp addObject:tabBarItem];
                [self addSubview:tabBarItem];
            }
        }
        _tabbarItems = [temp copy];
    }
}

- (void)setSelectedItemIndex:(NSUInteger)selectedItemIndex {
    
    if (selectedItemIndex < _tabbarItems.count) {
        
        FXTabBarItem *lastItem = _tabbarItems[_selectedItemIndex];
        FXTabBarItem *curItem = _tabbarItems[selectedItemIndex];
        
        lastItem.selected = NO;
        curItem.selected = YES;
        
        _selectedItemIndex = selectedItemIndex;
    }
}

- (void)setCenterItem:(UIButton *)centerItem {
    
    if (centerItem) {
        
        _centerItem = centerItem;
        [self addSubview:_centerItem];
    }
}

#pragma mark - Action

- (void)userClickedItem:(id)sender {
    
    NSInteger index = [_tabbarItems indexOfObject:sender];
    
    BOOL indexValid = NSNotFound != index;
    BOOL delegateMethodImplemented = [_fx_delegate respondsToSelector:@selector(fx_tabBar:didSelectItemAtIndex:)];
    
    if (indexValid) {
        self.selectedItemIndex = index;
    }
    
    if (indexValid && delegateMethodImplemented) {
        [_fx_delegate fx_tabBar:self didSelectItemAtIndex:index];
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    // Capturing touches on a subview outside the frame of its superview using hitTest:withEvent:
    if (!self.clipsToBounds && !self.hidden && self.alpha>0.0) {
        
        for (UIView *subview in self.subviews.reverseObjectEnumerator) {
            
            CGPoint subPoint = [self convertPoint:point toView:subview];
            UIView *result = [subview hitTest:subPoint withEvent:event];
            if (result) {
                return result;
            }
        }
    }
    
    return [super hitTest:point withEvent:event];
}

#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    BOOL hasCenterItem = _centerItem != nil;
    
    CGFloat barWidth = self.frame.size.width;
    CGFloat barHeight = self.frame.size.height;
    CGFloat itemWidth = hasCenterItem ? barWidth/(_tabbarItems.count + 1) : (barWidth/_tabbarItems.count);
    
    NSUInteger centerIndex = _tabbarItems.count / 2;

    if (hasCenterItem) {
        
        // the position(center) of centerItem in axis-Y obey below rule:
        // if centerItem's height is taller than tabBar's, so bottom-align; otherwise, center-align
        
        CGFloat centerItemHeight = [_centerItem imageForState:UIControlStateNormal].size.height;

        if (_centerItem.titleLabel.text > 0) {// reposition the iamge and title of centerItem
            
            // titleHeight should be equal to other item's
            CGFloat titleHeight = ceilf(self.frame.size.height * (1-FX_ItemImageHeightRatio));
            centerItemHeight += titleHeight;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
            if ([_centerItem respondsToSelector:@selector(fx_alignImageAndTitleVertically)]) {
                [_centerItem performSelector:@selector(fx_alignImageAndTitleVertically)];
            }
#pragma clang diagnostic pop
        }
        centerItemHeight = centerItemHeight<barHeight ? barHeight : centerItemHeight;
        
        CGFloat centerItemX = centerIndex * itemWidth;
        CGFloat centerItemY = centerItemHeight>barHeight ? (barHeight-centerItemHeight) : 0;
        
#ifdef FX_CenterItemYAsixOffset
        centerItemY += FX_CenterItemYAsixOffset;
#endif
        
        _centerItem.frame = CGRectMake(centerItemX, centerItemY, itemWidth, centerItemHeight);
    }
    
    for (int i = 0; i < _tabbarItems.count; i++) {
        
        FXTabBarItem *item = _tabbarItems[i];
        CGFloat itemX = (hasCenterItem && i>=centerIndex) ? itemWidth*(i+1) : itemWidth*i;
        item.frame = CGRectMake(itemX, 0, itemWidth, barHeight);
    }
}

@end

#pragma mark - UIButton + VerticalLayout

@interface UIButton (VerticalLayout)

- (void)fx_alignImageAndTitleVertically;

@end

@implementation UIButton (VerticalLayout)

- (void)fx_alignImageAndTitleVertically {
    
    CGSize imageSize = [self imageForState:UIControlStateNormal].size;
    CGSize titleSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: self.titleLabel.font}];
    
    // A positive value shrinks, or insets, that edge—moving it closer to the center of the button. A negative value expands, or outsets, that edge.
    
    self.imageEdgeInsets = UIEdgeInsetsMake(-titleSize.height, 0, 0, -titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width, -imageSize.height, 0);
}

@end