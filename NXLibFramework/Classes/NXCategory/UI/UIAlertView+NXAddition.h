//
//  UIAlertView+NXAddition.h
//  NXlib
//
//  Created by AK on 15/3/1.
//  Copyright (c) 2015年 AK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (NXAddition)

+ (void)nx_showWithMessage:(NSString *)message;
+ (void)nx_showWithTitle:(NSString *)title message:(NSString *)message;
+ (void)nx_showWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate;
+ (void)nx_showWithTitle:(NSString *)title
              message:(NSString *)message
             delegate:(id)delegate
    cancelButtonTitle:(NSString *)cancelButtonTitle
     otherButtonTitle:(NSString *)otherButtonTitle;
+ (void)nx_showWithTitle:(NSString *)title
              message:(NSString *)message
             delegate:(id)delegate
    cancelButtonTitle:(NSString *)cancelButtonTitle
     otherButtonTitle:(NSString *)otherButtonTitle
                  tag:(NSInteger)tag;

@end
