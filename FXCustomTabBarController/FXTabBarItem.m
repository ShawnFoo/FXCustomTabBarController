//
//  FXTabBarItem.m
//  CustomCenterItemTabbarDemo
//
//  Created by ShawnFoo on 16/1/24.
//  Copyright © 2016年 ShawnFoo. All rights reserved.
//

#import "FXTabBarItem.h"
#import "FXTabBarAppearanceConfigs.h"

#define FXStringFromSelectorName(name) NSStringFromSelector(@selector(name))

#pragma mark - Constants

static void* kFXTabBarItemContext;

@interface FXTabBarItem () {
    UIView *_tinyBadge;
}

@property (weak, nonatomic) UITabBarItem *tabBarItem;
@property (strong, nonatomic) UILabel *badgeLb;

@end

@implementation FXTabBarItem

+ (instancetype)itemWithTabbarItem:(UITabBarItem *)tabBarItem {
    
    NSParameterAssert(tabBarItem);
    
    FXTabBarItem *item = nil;
    if ([tabBarItem isKindOfClass:[UITabBarItem class]]) {

        item = [FXTabBarItem buttonWithType:UIButtonTypeCustom];

        item.imageView.contentMode = UIViewContentModeCenter;
        item.titleLabel.textAlignment = NSTextAlignmentCenter;
        item.backgroundColor = [UIColor clearColor];
        
        // custom configs
#ifdef FX_ItemTitleFontSize 
        item.titleLabel.font = [UIFont systemFontOfSize:FX_ItemTitleFontSize];
#endif
        [item setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [item addTarget:item action:@selector(userDidClickItem:) forControlEvents:UIControlEventTouchUpInside];

        // KVO
        item.tabBarItem = tabBarItem;
        NSKeyValueObservingOptions options = NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew;
        
        [tabBarItem addObserver:item
                     forKeyPath:FXStringFromSelectorName(title)
                        options:options
                        context:&kFXTabBarItemContext];
        [tabBarItem addObserver:item
                     forKeyPath:FXStringFromSelectorName(badgeValue)
                        options:options
                        context:&kFXTabBarItemContext];
        [tabBarItem addObserver:item
                     forKeyPath:FXStringFromSelectorName(image)
                        options:options
                        context:&kFXTabBarItemContext];
        [tabBarItem addObserver:item
                     forKeyPath:FXStringFromSelectorName(selectedImage)
                        options:options
                        context:&kFXTabBarItemContext];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        [tabBarItem addObserver:item
                     forKeyPath:FXStringFromSelectorName(fx_tinyBadgeVisible)
                        options:options
                        context:&kFXTabBarItemContext];
#pragma clang diagnostic pop
    }
    return item;
}

- (void)dealloc {
    
    [_tabBarItem removeObserver:self forKeyPath:FXStringFromSelectorName(badgeValue)];
    [_tabBarItem removeObserver:self forKeyPath:FXStringFromSelectorName(title)];
    [_tabBarItem removeObserver:self forKeyPath:FXStringFromSelectorName(image)];
    [_tabBarItem removeObserver:self forKeyPath:FXStringFromSelectorName(selectedImage)];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [_tabBarItem removeObserver:self forKeyPath:FXStringFromSelectorName(fx_tinyBadgeVisible)];
#pragma clang diagnostic pop
}

#pragma mark - Layout

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    if (!_tabBarItem.title.length) {
        return contentRect;
    }
    
    CGFloat imageWidth = contentRect.size.width;
    CGFloat imageHeight = ceilf(contentRect.size.height*FX_ItemImageHeightRatio);
    return CGRectMake(0, 0, imageWidth, imageHeight);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    if (!_tabBarItem.title.length) {
        return CGRectZero;
    }
    CGFloat titleY = ceilf(contentRect.size.height*FX_ItemImageHeightRatio);
    CGFloat titleWidth = contentRect.size.width;
    CGFloat titleHeight = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleWidth, titleHeight);
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

    if (context == &kFXTabBarItemContext) {
        
        if ([keyPath isEqualToString:FXStringFromSelectorName(badgeValue)]) {
            
            [self updateBadgeValue:_tabBarItem.badgeValue];
        }
        else if ([keyPath isEqualToString:FXStringFromSelectorName(image)]) {
            
            [self setImage:_tabBarItem.image forState:UIControlStateNormal];
        }
        else if ([keyPath isEqualToString:FXStringFromSelectorName(selectedImage)]) {

            [self setImage:_tabBarItem.selectedImage forState:UIControlStateSelected];
        }
        else if ([keyPath isEqualToString:FXStringFromSelectorName(title)]) {
           
            [self setTitle:_tabBarItem.title forState:UIControlStateNormal];
#ifdef FX_ItemTitleColor 
            NSDictionary *attrDic = @{
                                      NSForegroundColorAttributeName: FX_ItemTitleColor
                                      };
            NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:_tabBarItem.title
                                                                          attributes:attrDic];
            [self setAttributedTitle:attrStr forState:UIControlStateNormal];
#endif
#ifdef FX_ItemSelectedTitleColor
            NSDictionary *_attrDic = @{
                                      NSForegroundColorAttributeName: FX_ItemSelectedTitleColor
                                      };
            NSAttributedString *_attrStr = [[NSAttributedString alloc] initWithString:_tabBarItem.title
                                                                           attributes:_attrDic];
            [self setAttributedTitle:_attrStr forState:UIControlStateSelected];
#endif
            
        }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        else if ([keyPath isEqualToString:FXStringFromSelectorName(fx_tinyBadgeVisible)]) {
            
            if ([_tabBarItem respondsToSelector:@selector(fx_tinyBadgeVisible)]) {
                
                if ([_tabBarItem performSelector:@selector(fx_tinyBadgeVisible)]) {
                    [self presentTinyBadge];
                }
                else {
                    [self dismissTinyBadge];
                }
            }
        }
#pragma clang diagnostic pop
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - Action

- (void)userDidClickItem:(id)sender {

    self.selected = !self.selected;
}

#pragma mark - Effect

- (void)setHighlighted:(BOOL)highlighted {}

#pragma mark - Badge

- (UILabel *)badgeLb {
    
    if (!_badgeLb) {
        
        _badgeLb = [UILabel new];
         _badgeLb.font = [UIFont systemFontOfSize:FX_ItemBadgeFontSize];
        _badgeLb.textColor = [UIColor whiteColor];
        _badgeLb.textAlignment = NSTextAlignmentCenter;
#ifdef FX_BadgeBackgroundColor
        _badgeLb.backgroundColor = FX_BadgeBackgroundColor;
#else
        _badgeLb.backgroundColor = [UIColor redColor];
#endif
        _badgeLb.layer.masksToBounds = YES;
    }
    
    return _badgeLb;
}

- (void)updateBadgeValue:(NSString *)value {
    
    !value || [value isEqualToString:@"0"] ? [self removeBadge] : [self refreshBadgeWithValue:value];
}

- (void)refreshBadgeWithValue:(NSString *)value {
    
    [self dismissTinyBadge];
    
    CGSize badgeSize = [self sizeOfBadgeValue:value];
    
    // Manually triggering FXTabBarView's layoutSubview method in order to get real item frame
    if (self.frame.size.width == 0) {
        [self.superview layoutIfNeeded];
    }
    
    CGFloat badgeX = self.frame.size.width - badgeSize.width;
    CGFloat badgeY = 0;
    
#ifdef FX_BadgeXAsixOffset
    badgeX += FX_BadgeXAsixOffset;
#endif
#ifdef FX_BadgeYAsixOffset
    badgeY += FX_BadgeYAsixOffset;
#endif
    
    if (![self.subviews containsObject:self.badgeLb]) {// not existed
        
        _badgeLb.frame = CGRectMake(badgeX, badgeY, badgeSize.width, badgeSize.height);
        _badgeLb.layer.cornerRadius = badgeSize.height / 2.0;
        _badgeLb.alpha = 0.0;
        _badgeLb.transform = CGAffineTransformMakeScale(0, 0);
        
        [self addSubview:_badgeLb];
        [UIView animateWithDuration:0.33
                              delay:0
             usingSpringWithDamping:0.66
              initialSpringVelocity:1
                            options:0
                         animations:^
        {
            _badgeLb.alpha = 1.0;
            _badgeLb.transform = CGAffineTransformIdentity;
        } completion:nil];
    }
    else {// if existed, only change the frame of item
        
        [UIView animateWithDuration:0.33
                              delay:0
             usingSpringWithDamping:0.66
              initialSpringVelocity:1
                            options:0
                         animations:^
        {
            _badgeLb.frame = CGRectMake(badgeX, badgeY, badgeSize.width, badgeSize.height);
        } completion:nil];
    }
    // update the badge value!
    
#ifdef FX_BadgeValueColor
    NSDictionary *attrDic = @{NSForegroundColorAttributeName: FX_BadgeValueColor};
    self.badgeLb.attributedText = [[NSAttributedString alloc] initWithString:value attributes:attrDic];
#else
    self.badgeLb.text = value;
#endif
}

- (void)removeBadge {
    
    if (_badgeLb) {
        
        [UIView transitionWithView:self
                          duration:0.4
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^
        {
            _badgeLb.transform = CGAffineTransformMakeScale(0, 0);
            _badgeLb.alpha = 0.5;
        } completion:^(BOOL finished) {
            [_badgeLb removeFromSuperview];
            _badgeLb = nil;
        }];
    }
}

- (CGSize)sizeOfBadgeValue:(NSString *)value {
    
    CGSize size = [value sizeWithAttributes:@{
                                              NSFontAttributeName: [UIFont systemFontOfSize:FX_ItemBadgeFontSize]
                                              }];

    BOOL addPadding = YES;
    // make sure the item is a round if the length of badge value is too short
    if (size.height > size.width) {
        size.width = size.height;
        addPadding = NO;
    }
    
    return CGSizeMake(ceilf(size.width+2*FX_ItemBadgeHPadding*addPadding), ceilf(size.height));
}

#pragma mark Tiny Badge

- (void)presentTinyBadge {
    
    [self removeBadge];
    
    if (!_tinyBadge) {
        
        _tinyBadge = [UIView new];
#ifdef FX_TinyBadgeColor
        _tinyBadge.backgroundColor = FX_TinyBadgeColor;
#else
        _tinyBadge.backgroundColor = [UIColor redColor];
#endif
        _tinyBadge.layer.cornerRadius = FX_TinyBadgeRadius;
        
        // locate the tiny badge to the right top corner of the image
        UIImage *image = [self imageForState:UIControlStateNormal];
        CGSize size = image.size;
        
        if (self.frame.size.width == 0) {
            [self.superview layoutIfNeeded];
        }
        CGFloat mX = self.frame.size.width / 2.0; // center X
        CGFloat rX = mX + size.width / 2.0;       // trailing X
        
#ifdef FX_BadgeXAsixOffset
        rX += FX_BadgeXAsixOffset;
#endif
        
        BOOL hasTitle = _tabBarItem.title.length > 0;
        
        CGFloat y0 = hasTitle ? ceilf(self.frame.size.height*FX_ItemImageHeightRatio-size.height) : (self.frame.size.height-size.height);
        
#ifdef FX_BadgeYAsixOffset
        y0 += FX_BadgeYAsixOffset;
#endif
        
        CGRect tinyBadgeFrame = {{rX, y0}, FX_TinyBadgeRadius*2.0, FX_TinyBadgeRadius*2.0};
        _tinyBadge.frame = tinyBadgeFrame;
        _tinyBadge.transform = CGAffineTransformMakeScale(0, 0);
        _tinyBadge.alpha = 0.0;
        [self addSubview:_tinyBadge];
        
        [UIView animateWithDuration:0.33
                              delay:0
             usingSpringWithDamping:0.6
              initialSpringVelocity:1
                            options:0
                         animations:^
        {
            _tinyBadge.transform = CGAffineTransformIdentity;
            _tinyBadge.alpha = 1.0;
        } completion:nil];
    }
}

- (void)dismissTinyBadge {
    
    if (_tinyBadge) {

        [UIView animateWithDuration:0.33 animations:^{
            _tinyBadge.alpha = 0.0;
            _tinyBadge.transform = CGAffineTransformMakeScale(0.1, 0.1);
        } completion:^(BOOL finished){
            [_tinyBadge removeFromSuperview];
            _tinyBadge = nil;
        }];
    }
}

@end