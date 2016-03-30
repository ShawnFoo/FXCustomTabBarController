<h1>FXCustomTabBarController<a href="#10">中文版</a></h1>

![build](https://img.shields.io/badge/build-passing-green.svg)
![ObjC](https://img.shields.io/badge/iOS-7.0%2B-orange.svg)
![pod](https://img.shields.io/badge/Cocoapods-v0.1.2-blue.svg)
![compatible](https://img.shields.io/badge/compatible-Objective--C%2FSwift-yellow.svg)

A category of UITabBarController with various custom styles for you to achieve any kinds of the tabBar you like with less work!

---
1. [Custom Styles](#1)
2. [Preview](#2)
3. [Installation](#3)
4. [How to use it](#4)
5. [Demos](#5)
6. [Xcode6.4 Issue For StoryBoard](#6)

<h2 id="1">Custom Styles</h2>
Not only can you create TabBarController **`programmatically`**, but also can use **`StoryBoard`** to set up TabBarController, also tabBarItem's title and images!

* CenterItem(Image、HighlightedImage、Title)
* UITabBar(Height、Background)
* TabBarItem(OriginalImage、TitleColor、SelectedTitleColor、TitleFontSize)
* NormalBadge(BackgroundColor、ValueColor、FontSize)
* TinyBadge(Color、Radius)
* Slider(Color) that will silde to the item you clicked.You can also custom its spring damping value
* etc..

<h2 id="2">Preview</h2>

![tinyBadge](http://ww4.sinaimg.cn/mw690/9161297cgw1f1tdes2zkmj207i0dct9e.jpg)
![badgeValue](http://ww4.sinaimg.cn/mw690/9161297cgw1f1tdeq6bcsj207i0dc74z.jpg)
![slider](http://ww1.sinaimg.cn/mw690/9161297cgw1f1uipytac8j207i0dcaa1.jpg)
![noTitle](http://ww3.sinaimg.cn/mw690/9161297cgw1f1tder955pj207i0dcjs2.jpg)
![background](http://ww1.sinaimg.cn/mw690/9161297cgw1f1tdejisftj207i0dcq3q.jpg)
![noTitles](http://ww1.sinaimg.cn/mw690/9161297cgw1f1tderi65hj207i0dcdgh.jpg)

<h2 id="3">Installation</h2>

####For Objective-C Project

#####Cocoapods(iOS7+)

1. Add these lines below to your Podfile 
	
	```
	platform :ios, '7.0'
	pod 'FXCustomTabBarController'
	```
2. Install the pod by running `pod install`

#####Manually(iOS6+ In theory, No test for iOS6)

Drag `FXCustomTabBarController` document to your project

####For Swift Project

#####Cocoapods(iOS8+)

1. Add these lines below to your Podfile 
	
	```
	platform :ios, '8.0'
	use_frameworks!
	pod 'FXCustomTabBarController'
	```
2. pod install
3. import FXCustomTabBarController

#####Manually(iOS7+)

1. Drag `FXCustomTabBarController` document to your project
2. Add ProjectName-Bridging-Header.h also import UITabBarController+FXCustomTabBar.h

<h2 id="4">How to use it</h2>

###General

1. Create UITabBarController and set its viewControllers with each UITabBarItem by Storyboard or Programmatically way
2. Set up centerItem or tabBar's backgroundImage by calling the methods declared in the header file of UITabBarController+FXCustomTabBar category
3. Set up other styles in FXTabBarAppearanceConfigs header file

### UITabBarController+FXCustomTabBar

Make sure you have already `#import UITabBarController+FXCustomTabBar.h`

````
- (void)fx_setupCenterItemWithImage:(UIImage *)image;

- (void)fx_setupCenterItemWithImage:(UIImage *)image title:(NSString *)title;

- (void)fx_setupCenterItemWithImage:(UIImage *)image highligtedImage:(UIImage *)highlightedImage;

- (void)fx_setupCenterItemWithImage:(UIImage *)image highligtedImage:(UIImage *)highlightedImage title:(NSString *)title;

- (void)fx_setCenterItemClickedEventHandler:(FXEventHandler)handler;
````

### FXTabBarAppearanceConfigs

```
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

// slider visibility(set false won't create slider for you)
#define FX_SliderVisible false

// slider color(hex number of rgb color), default is lightGrayColor
#define FX_SliderColor UIColorFromHexRGB(0x87CEFA)

// slider spring damping: To smoothly decelerate the animation without oscillation, use a value of 1. Employ a damping ratio closer to zero to increase oscillation.
#define FX_SliderDamping 0.66

// remove tabBar top shadow if this value true; otherwise, keep system style
#define FX_RemoveTabBarTopShadow true

#define FX_ItemTitleFontSize 10

// the ratio of image's height to item's.  (0 ~ 1)
#define FX_ItemImageHeightRatio 0.7

#define FX_ItemBadgeFontSize 13

// horizontal padding
#define FX_ItemBadgeHPadding 4

// radius of tiny badge(dot)
#define FX_TinyBadgeRadius 3
```

<h2 id="5">Demo</h2>

There are three demos in all. Two of them(ProgrammaticallyDemo、StoryBoardDemo)are Objective-C projects. The remaining one, SwiftDemo, is Swift project.

<h2 id="6">Xcode6.4 Issue For StoryBoard</h2>

For Xcode6.4,You might meet this issue when setting seletedImage for TabBarItem by StoryBoard: 

`CUICatalog: Invalid asset name supplied: (null)`

For now, I have tested in Xcode6.4 and Xcode7+, and this issue only appears in Xcode6.4

Here is the solution:
<a href="http://stackoverflow.com/questions/22011106/error-cuicatalog-invalid-asset-name-supplied-null-or-invalid-scale-factor">stackoverflow</a>
![issue](http://ww4.sinaimg.cn/mw690/9161297cgw1f1uglu0nduj20im0j841i.jpg)


<h1 id="10">FXCustomTabBarController</h1>
一个包含多种自定义风格的UITabBarController类簇, 用更少的代码去实现各种你喜欢的UITabBar

---
1. [自定义风格](#11)
2. [图片预览](#2)
3. [安装方式](#12)
4. [如何使用](#13)
5. [Demo](#5)
6. [XCode6.4中StoryBoard设置TabBarItem选中状态的图片的方法](#6)

<h2 id="11">自定义风格</h2>
不仅可以通过`代码`创建UITabBarController, 还支持使用`Storyboard`创建UITabBarController, 及设置其tabBarItem的标题、图片(选中状态的图片) 以实现你自己的Style. 

* CenterItem(Image、HighlightedImage、Title)
* UITabBar(高度、背景图片)
* TabBarItem(原图、TitleColor、SelectedTitleColor、TitleFontSize)
* 普通的Badge(BackgroundColor、ValueColor、FontSize)
* 小圆点(Color、Radius)
* 滑块(Color), 点哪滑哪, 效果可看Demo
* 等等..

<h2 id="12">安装方式</h2>

####Objective-C 项目

#####Cocoapods(iOS7+)

1. 在Podfile中添加如下信息
	
	```
	platform :ios, '7.0'
	pod 'FXCustomTabBarController'
	```
2. 项目目录中运行终端指令 `pod install`

#####Manually(理论上支持iOS6+, iOS6无测试)

拖动 `FXCustomTabBarController` 文件夹到你的项目中

####Swift 项目

#####Cocoapods(iOS8+)

1. 在Podfile中添加如下信息
	
	```
	platform :ios, '8.0'
	use_frameworks!
	pod 'FXCustomTabBarController'
	```
2. pod install
3. import FXCustomTabBarController

#####Manually(iOS7+)

1. 拖动 `FXCustomTabBarController` 文件夹到你的项目中
2. 添加 ProjectName-Bridging-Header.h 文件(Xcode可能会帮助你创建桥梁文件, 否则要自己创建并添加关联了), 同时在其中 import UITabBarController+FXCustomTabBar.h

<h2 id="13">如何使用</h2>

###总体分这三步

1. 通过代码或者Stroyboard创建好UITabBarController
2. 在通过类簇提供的方法设置CenterItem、CenterItem的点击事件handlerBlock或者TabBar背景图片
3. 在FXTabBarAppearanceConfigs头文件中设置其他自定义样式的参数

### UITabBarController+FXCustomTabBar 类簇的方法

要先`#import UITabBarController+FXCustomTabBar.h`噢

````
- (void)fx_setupCenterItemWithImage:(UIImage *)image;

- (void)fx_setupCenterItemWithImage:(UIImage *)image title:(NSString *)title;

- (void)fx_setupCenterItemWithImage:(UIImage *)image highligtedImage:(UIImage *)highlightedImage;

- (void)fx_setupCenterItemWithImage:(UIImage *)image highligtedImage:(UIImage *)highlightedImage title:(NSString *)title;

- (void)fx_setCenterItemClickedEventHandler:(FXEventHandler)handler;
````

### FXTabBarAppearanceConfigs 各种参数配置 头文件

```
// the height of view for each childViewController of UITabBarController will vary with the tabBar height
#define FX_TabBarHeight 40

// centerItem在Y轴上的偏移量
//#define FX_CenterItemYAsixOffset 0 

// badge在X轴上的偏移量
#define FX_BadgeXAsixOffset -4

// badge在Y轴上的偏移量
#define FX_BadgeYAsixOffset 2

// TabBarItem标题颜色(请使用十六进制数值)
#define FX_ItemTitleColor UIColorFromHexRGB(0xC0C0C0)

// TabBarItem选中状态下 标题的颜色
#define FX_ItemSelectedTitleColor UIColorFromHexRGB(0x000000)

// badge背景颜色
#define FX_BadgeBackgroundColor UIColorFromHexRGB(0xFFA500)

// badge显示文本 的颜色
#define FX_BadgeValueColor UIColorFromHexRGB(0x6B8E23)

// 小圆点颜色
#define FX_TinyBadgeColor UIColorFromHexRGB(0xFFA500)

// 滑块是否可见 (设置为false或注释掉下边这个宏 都不会自动创建slider)
#define FX_SliderVisible false

// 滑块颜色
#define FX_SliderColor UIColorFromHexRGB(0x87CEFA)

// 滑块阻尼系数(0~1): 数值越接近1最后减速时的震荡就越小, 反之越接近0越大, 具体可看苹果文档
#define FX_SliderDamping 0.66

// 移除TabBar顶部阴影
#define FX_RemoveTabBarTopShadow true

// TabBarItem标题字体大小
#define FX_ItemTitleFontSize 10

// TabBarItem中图片高度所占的比例.(图片高度/item高度)  (0 ~ 1)
#define FX_ItemImageHeightRatio 0.7

// badge显示文字 的字体大小 
#define FX_ItemBadgeFontSize 13

// TabBarItem水平内间距
#define FX_ItemBadgeHPadding 4

// 小圆点的半径
#define FX_TinyBadgeRadius 3
```
