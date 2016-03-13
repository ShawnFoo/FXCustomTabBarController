//
//  NSObject+FXAlertView.h
//
//
//  Created by ShawnFoo on 10/9/15.
//  Copyright © 2015 shawnfoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIAlertView.h>

// Still working on refactoring my util classes..I have to say it's hard to use it since too many params there

@interface NSObject (FXAlertView) <UIAlertViewDelegate, UIActionSheetDelegate>

/**
 *  `简单`弹出系统自带 确认窗口(两个按钮:确定和取消)或消息通知窗口(一个按钮:取消功能); 兼容iOS7及以上版本,
        iOS7无需另外实现UIAlertViewDelegate的代理方法, 该Catogory会处理..
 *
 *  @param title            提示窗口标题
 *  @param message          提示消息
 *  @param confirmTitle     确定按钮标题 (设置为nil, 即为仅包含1个取消按钮的消息通知窗口)
 *  @param cancelTitle      取消按钮标题 (nil 则为`取消`)
 *  @param confirmHandler   点击确定按钮执行的block, 不需要则设置nil
 *  @param cancelHandler    点击取消按钮执行的block, 不需要则设置nil
 */
- (void)presentConfirmViewWithTitle:(nonnull NSString *)title
                            message:(nonnull NSString *)message
                 confirmButtonTitle:(nullable NSString *)confirmTitle
                  cancelButtonTitle:(nullable NSString *)cancelTitle
                     confirmHandler:(nullable void (^)(void))confirmHandler
                      cancelHandler:(nullable void (^)(void))cancelHandler;

/**
 *  弹出系统自带 确认窗口(两个按钮:确定和取消)或消息通知窗口(一个按钮:取消功能); 兼容iOS7及以上版本,
 iOS7无需另外实现UIAlertViewDelegate的代理方法, 该Catogory会处理..
 *
 *  @param controller     呈现AlertView的Controller(nil则为:KeyWindow的rootController)
 *  @param title          提示窗口标题
 *  @param message        提示消息
 *  @param confirmTitle   确定按钮标题 (设置为nil, 即为仅包含1个取消按钮的消息通知窗口)
 *  @param cancelTitle    取消按钮标题 (nil 则为`取消`)
 *  @param confirmHandler 点击确定按钮执行的block, 不需要则设置nil
 *  @param cancelHandler  点击取消按钮执行的block, 不需要则设置nil
 */
- (void)presentConfirmViewInController:(nullable id)controller
                          confirmTitle:(nonnull NSString *)title
                               message:(nonnull NSString *)message
                    confirmButtonTitle:(nullable NSString *)confirmTitle
                     cancelButtonTitle:(nullable NSString *)cancelTitle
                        confirmHandler:(nullable void (^)(void))confirmHandler
                         cancelHandler:(nullable void (^)(void))cancelHandler;

/**
 *  `简单`弹出系统自带 选择表单; 兼容iOS7及以上版本; iOS7无需另外实现UIActionSheetDelegate的代理方法, 该Catogory会处理..
 *
 *  @param title              标题(nil则无标题)
 *  @param cancelTitle        取消按钮标题(nil则为:取消)
 *  @param twoOtherTitleArray 另外两个选择按钮的标题, NSString数组(按先后顺序展示)
 *  @param firstSelBTHandler  第一个选择按钮触发的Handler Block
 *  @param secondSelBTHandler 第二个选择按钮触发的Handler Block
 */
- (void)presentSelectSheetWithTitle:(nonnull NSString *)title
                  cancelButtonTitle:(nonnull NSString *)cancelTitle
          twoOtherButtonTitlesArray:(nonnull NSArray<NSString *> *)twoOtherTitleArray
                     firstBTHandler:(nullable void (^)(void))firstBTHandler
                    secondBTHandler:(nullable void (^)(void))secondBTHandler;

/**
 *  弹出系统自带 选择表单, 需指定presentingController; 兼容iOS7及以上版本; iOS7无需另外实现UIActionSheetDelegate的代理方法, 该Catogory会处理..
 *
 *  @param controller         呈现ActionSheet的Controller(nil则为:KeyWindow的rootController)
 *  @param title              标题(nil则无标题)
 *  @param cancelTitle        取消按钮标题(nil则为:取消)
 *  @param twoOtherTitleArray 另外两个选择按钮的标题, NSString数组(按先后顺序展示)
 *  @param firstSelBTHandler  第一个选择按钮触发的Handler Block
 *  @param secondSelBTHandler 第二个选择按钮触发的Handler Block
 */
- (void)presentSelectSheetByController:(nullable id)controller
                            sheetTitle:(nonnull NSString *)title
                     cancelButtonTitle:(nonnull NSString *)cancelTitle
             twoOtherButtonTitlesArray:(nonnull NSArray<NSString *> *)twoOtherTitleArray
                        firstBTHandler:(nullable void (^)(void))firstBTHandler
                       secondBTHandler:(nullable void (^)(void))secondBTHandler;

@end


