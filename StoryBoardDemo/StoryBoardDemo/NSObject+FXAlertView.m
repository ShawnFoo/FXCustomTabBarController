//
//  NSObject+FXAlertView.m
//
//
//  Created by ShawnFoo on 10/9/15.
//  Copyright © 2015 shawnfoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "NSObject+FXAlertView.h"

#define SysVersionBiggerThaniOS7 [[UIDevice currentDevice].systemVersion floatValue] >= 8.0

#ifdef DEBUG
#define MyLog(format, ...) NSLog((@"\n%s [Line %d]\n" format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define MyLog(...) do {} while(0)
#endif

#define RunBlock_Safe(block) {\
    if (block) {\
        block();\
    }\
}\

@implementation NSObject (FXAlertView)

#pragma mark - Private

/**
 *  返回一个view存在于视图阶层上的controller(如无特殊情况, 一般返回最顶层root Controller), 用于呈现AlertViewController, 兼容iOS7以上版本
    (主要是为了兼容iOS9..)
 */
- (UIViewController *)controllerInViewHierarchy {
    
    UIViewController *mostTopController = KeyWindow.rootViewController;
    // presentedViewController: The view controller that is presented by this view controller, one of its ancestors in the view controller hierarchy
    while (mostTopController.presentedViewController) {
        mostTopController = mostTopController.presentedViewController;
    }
    
    return mostTopController;
}

#pragma mark - Public
#pragma mark ConfirmView

- (void)presentConfirmViewWithTitle:(NSString *)title
                            message:( NSString *)message
                 confirmButtonTitle:(NSString *)confirmTitle
                  cancelButtonTitle:(NSString *)cancelTitle
                     confirmHandler:(void (^)(void))confirmHandler
                      cancelHandler:(void (^)(void))cancelHandler {
    
    [self presentConfirmViewInController:nil
                                   confirmTitle:title
                                 message:message
                      confirmButtonTitle:confirmTitle
                       cancelButtonTitle:cancelTitle
                          confirmHandler:confirmHandler
                           cancelHandler:cancelHandler];
}

- (void)presentConfirmViewInController:(id)controller
                          confirmTitle:(NSString *)title
                               message:( NSString *)message
                    confirmButtonTitle:(NSString *)confirmTitle
                     cancelButtonTitle:(NSString *)cancelTitle
                        confirmHandler:(void (^)(void))confirmHandler
                         cancelHandler:(void (^)(void))cancelHandler {
    
    NSString *cancelTitleStr = cancelTitle?:@"取消";
    
    UIViewController *viewController = controller?:[self controllerInViewHierarchy];
    
    if (SysVersionBiggerThaniOS7) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        // Create the action.
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitleStr style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            RunBlock_Safe(cancelHandler);
        }];
        // Add the action.
        [alertController addAction:cancelAction];
        
        if (confirmTitle) {
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                RunBlock_Safe(confirmHandler)
            }];
            [alertController addAction:otherAction];
        }
        
        [viewController presentViewController:alertController animated:YES completion:nil];
    }
    else { // iOS7
        
        UIAlertView *alertView;
        
        if (confirmTitle) {
            alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:viewController cancelButtonTitle:cancelTitleStr otherButtonTitles:confirmTitle, nil];
        }
        else {
            alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:viewController cancelButtonTitle:cancelTitleStr otherButtonTitles:nil];
        }
        
        alertView.alertViewStyle = UIAlertViewStyleDefault;
        
        void (^alertViewClickAction)(NSUInteger) =  ^(NSUInteger buttonIndex) {
    
            if (!buttonIndex) {
                RunBlock_Safe(cancelHandler)
            }
            else {
                RunBlock_Safe(confirmHandler)
            }
        };
        
        objc_setAssociatedObject(alertView, @selector(presentConfirmViewWithTitle:message:confirmButtonTitle:cancelButtonTitle:confirmHandler:cancelHandler:), alertViewClickAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
        
        [alertView show];
    }
}

#pragma mark iOS7 UIAlertView Delegate method

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    void (^alertViewClickAction)(NSUInteger) = objc_getAssociatedObject(alertView, @selector(presentConfirmViewWithTitle:message:confirmButtonTitle:cancelButtonTitle:confirmHandler:cancelHandler:));
    
    if (alertViewClickAction) {
        alertViewClickAction(buttonIndex);
    }
}

#pragma mark SelectActionSheet

- (void)presentSelectSheetWithTitle:(NSString *)title
                  cancelButtonTitle:(NSString *)cancelTitle
          twoOtherButtonTitlesArray:(NSArray *)twoOtherTitleArray
                     firstBTHandler:(void (^)(void))firstBTHandler
                    secondBTHandler:(void (^)(void))secondBTHandler {
    
    [self presentSelectSheetByController:nil
                              sheetTitle:title
                       cancelButtonTitle:cancelTitle
               twoOtherButtonTitlesArray:twoOtherTitleArray
                          firstBTHandler:firstBTHandler
                         secondBTHandler:secondBTHandler];
}

- (void)presentSelectSheetByController:(id)controller
                            sheetTitle:(NSString *)title
                     cancelButtonTitle:(NSString *)cancelTitle
             twoOtherButtonTitlesArray:(NSArray *)twoOtherTitleArray
                        firstBTHandler:(void (^)(void))firstBTHandler
                       secondBTHandler:(void (^)(void))secondBTHandler {
    
    NSString *cancelTitleStr = cancelTitle?:@"取消";
    
    UIViewController *viewController = controller?:[self controllerInViewHierarchy];
    
    if (SysVersionBiggerThaniOS7) {// iOS8
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        // Create the action.
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitleStr style:UIAlertActionStyleCancel handler:nil];
        
        UIAlertAction *firstOtherAction = [UIAlertAction actionWithTitle:twoOtherTitleArray[0] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            RunBlock_Safe(firstBTHandler);
        }];
        
        UIAlertAction *secondOtherAction = [UIAlertAction actionWithTitle:twoOtherTitleArray[1] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            RunBlock_Safe(secondBTHandler);
        }];
        
        // Add the action.
        [alertController addAction:cancelAction];
        [alertController addAction:firstOtherAction];
        [alertController addAction:secondOtherAction];
        
        [viewController presentViewController:alertController animated:YES completion:nil];
    }
    else { // iOS7
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title
                                                                 delegate:viewController
                                                        cancelButtonTitle:cancelTitleStr
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:twoOtherTitleArray[0], twoOtherTitleArray[1], nil];
        
        void (^sheetClickAction)(NSUInteger) =  ^(NSUInteger buttonIndex) {
            
            switch (buttonIndex) {
                case 0:
                    RunBlock_Safe(firstBTHandler);
                    break;
                case 1:
                    RunBlock_Safe(secondBTHandler);
                    break;
                default:
                    break;
            }
        };
        
        objc_setAssociatedObject(actionSheet, @selector(presentSelectSheetWithTitle:cancelButtonTitle:twoOtherButtonTitlesArray:firstBTHandler:secondBTHandler:), sheetClickAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
        
        [actionSheet showInView:viewController.view];
    }
}

#pragma mark iOS7 UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    void (^sheetClickAction)(NSUInteger) = objc_getAssociatedObject(actionSheet, @selector(presentSelectSheetWithTitle:cancelButtonTitle:twoOtherButtonTitlesArray:firstBTHandler:secondBTHandler:));
    
    if (sheetClickAction) {
        sheetClickAction(buttonIndex);
    }
}

@end
