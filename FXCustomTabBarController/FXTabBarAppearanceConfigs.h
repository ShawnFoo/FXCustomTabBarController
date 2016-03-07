//
//  FXTabBarAppearanceConfigs.h
//  CustomCenterItemTabbarDemo
//
//  Created by ShawnFoo on 16/2/28.
//  Copyright © 2016年 ShawnFoo. All rights reserved.
//

// Here are some appearance proerties customed on your requirements
#ifndef FXTabBarAppearanceConfigs_h
#define FXTabBarAppearanceConfigs_h

// ====================    Optional Contants Start    ====================
// Please feel free to comment out some properties if you prefer the system's default appearance

// the height of view for each childViewController of UITabBarController will vary with the tabBar height
#define FX_TabBarHeight 40

// the offset for the position(center) of centerItem in Y-Asix. Negetive num will make centerItem move up; otherwise, move down
//#define FX_CenterItemYAsixOffset 0 

// the offset for the postion of badge(also tinyBadge) in X-Asix. Negetive num will make badge move left; otherwise, move right
#define FX_BadgeXAsixOffset -4

// the offset for the postion of badge(also  tinyBadge) in Y-Asix. Negetive num will make badge move up; otherwise, move down
#define FX_BadgeYAsixOffset 2

// item title color for UIControlStateNormal(hex number of rgb color)
#define FX_ItemTitleColor UIColorFromHexRGB(0xC0C0C0)

// selected item title color for UIControlStateSelected(hex number of rgb color)
#define FX_ItemSelectedTitleColor UIColorFromHexRGB(0x000000)

// badge background color(hex number of rgb color)
#define FX_BadgeBackgroundColor UIColorFromHexRGB(0xFFA500)

// badge value color(hex number of rgb color)
#define FX_BadgeValueColor UIColorFromHexRGB(0x6B8E23)

// tiny badge color(hex number of rgb color), default is redColor
#define FX_TinyBadgeColor UIColorFromHexRGB(0xFFA500)

// remove tabBar top shadow if this value true; otherwise, keep system style
#define FX_RemoveTabBarTopShadow true

// ====================    Optional Contants End    ====================


// --------------------      Required Constants Start    --------------------
// Please think twice before you comment out any macros below..But feel free to change any values to meet your requirements

#define FX_ItemTitleFontSize 10

// the ratio of image's height to item's.  (0 ~ 1)
#define FX_ItemImageHeightRatio 0.7

#define FX_ItemBadgeFontSize 13

// horizontal padding
#define FX_ItemBadgeHPadding 4

// radius of tiny badge(dot)
#define FX_TinyBadgeRadius 3

// --------------------      Required Constants End    --------------------


// ====================      PreDefined Macro Start       ====================

#define UIColorFromHexRGB(rgbValue) \
([UIColor colorWithRed:((float)((rgbValue&0xFF0000)>>16))/255.0 \
green:((float)((rgbValue&0xFF00)>>8))/255.0 \
blue:((float)(rgbValue&0xFF))/255.0 \
alpha:1])

#define FXSwizzleInstanceMethod(class, originalSEL, swizzleSEL) {\
Method originalMethod = class_getInstanceMethod(class, originalSEL);\
Method swizzleMethod = class_getInstanceMethod(class, swizzleSEL);\
BOOL didAddMethod = class_addMethod(class, originalSEL, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));\
if (didAddMethod) {\
class_replaceMethod(class, swizzleSEL, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));\
}\
else {\
method_exchangeImplementations(originalMethod, swizzleMethod);\
}\
}

//  ====================      PreDefined Macro End       ====================

#endif /* FXTabBarAppearanceConfigs_h */
