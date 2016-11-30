//
//  NXAlertView.h
//  NXlib
//
//  Created by AK on 14/12/8.
//  Copyright (c) 2014年 AK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^NXAlertViewClickedHandler)(UIAlertView *alertView,
                                          NSInteger buttonIndex);
typedef void (^NXAlertViewCancelHandler)(UIAlertView *alertView);
typedef void (^NXAlertViewWillPresentHandler)(UIAlertView *alertView);
typedef void (^NXAlertViewDidPresentHandler)(UIAlertView *alertView);
typedef void (^NXAlertViewWillDismissHandler)(UIAlertView *alertView,
                                              NSInteger buttonIndex);
typedef void (^NXAlertViewDidDismissHandler)(UIAlertView *alertView,
                                             NSInteger buttonIndex);
typedef BOOL (^NXAlertViewShouldEnableHandler)(UIAlertView *alertView);

@interface NXAlertView : UIAlertView

- (void)setClickedHandler:(NXAlertViewClickedHandler)clickedHandler;
- (void)setCancelHandler:(NXAlertViewCancelHandler)cancelHandler;
- (void)setWillPresentHandler:(NXAlertViewWillPresentHandler)willPresentHandler;
- (void)setDidPresentHandler:(NXAlertViewDidPresentHandler)didPresentHandler;
- (void)setWillDismissHandler:(NXAlertViewWillDismissHandler)willDismissHandler;
- (void)setDidDismissHandler:(NXAlertViewDidDismissHandler)didDismissHandler;
- (void)setShouldEnableHandler:
    (NXAlertViewShouldEnableHandler)shouldEnableHandler;

@end
