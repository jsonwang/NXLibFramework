//
//  NXAlertView.m
//  NXlib
//
//  Created by AK on 14/12/8.
//  Copyright (c) 2014年 AK. All rights reserved.
//

#import "NXAlertView.h"

@interface NXAlertView ()<UIAlertViewDelegate>

@property(nonatomic, copy) NXAlertViewClickedHandler clickedHandler;
@property(nonatomic, copy) NXAlertViewCancelHandler cancelHandler;
@property(nonatomic, copy) NXAlertViewWillPresentHandler willPresentHandler;
@property(nonatomic, copy) NXAlertViewDidPresentHandler didPresentHandler;
@property(nonatomic, copy) NXAlertViewWillDismissHandler willDismissHandler;
@property(nonatomic, copy) NXAlertViewDidDismissHandler didDismissHandler;
@property(nonatomic, copy) NXAlertViewShouldEnableHandler shouldEnableHandler;

@end

@implementation NXAlertView

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.clickedHandler)
    {
        self.clickedHandler(alertView, buttonIndex);
    }
}

- (void)alertViewCancel:(UIAlertView *)alertView
{
    if (self.cancelHandler)
    {
        self.cancelHandler(alertView);
    }
}

- (void)willPresentAlertView:(UIAlertView *)alertView
{
    if (self.willPresentHandler)
    {
        self.willPresentHandler(alertView);
    }
}

- (void)didPresentAlertView:(UIAlertView *)alertView
{
    if (self.didPresentHandler)
    {
        self.didPresentHandler(alertView);
    }
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (self.willDismissHandler)
    {
        self.willDismissHandler(alertView, buttonIndex);
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (self.didDismissHandler)
    {
        self.didDismissHandler(alertView, buttonIndex);
    }
}

- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView
{
    if (self.shouldEnableHandler)
    {
        self.shouldEnableHandler(alertView);
    }
    return YES;
}

#pragma mark - Public Method

- (void)setClickedHandler:(NXAlertViewClickedHandler)clickedHandler
{
    self.delegate = self;

    _clickedHandler = nil;
    _clickedHandler = [clickedHandler copy];
}

- (void)setCancelHandler:(NXAlertViewCancelHandler)cancelHandler
{
    self.delegate = self;

    _cancelHandler = nil;
    _cancelHandler = [cancelHandler copy];
}

- (void)setWillPresentHandler:(NXAlertViewWillPresentHandler)willPresentHandler
{
    self.delegate = self;

    _willPresentHandler = nil;
    _willPresentHandler = [willPresentHandler copy];
}

- (void)setDidPresentHandler:(NXAlertViewDidPresentHandler)didPresentHandler
{
    self.delegate = self;

    _didPresentHandler = nil;
    _didPresentHandler = [didPresentHandler copy];
}

- (void)setWillDismissHandler:(NXAlertViewWillDismissHandler)willDismissHandler
{
    self.delegate = self;

    _willDismissHandler = nil;
    _willDismissHandler = [willDismissHandler copy];
}

- (void)setDidDismissHandler:(NXAlertViewDidDismissHandler)didDismissHandler
{
    self.delegate = self;

    _didDismissHandler = nil;
    _didDismissHandler = [didDismissHandler copy];
}

- (void)setShouldEnableHandler:(NXAlertViewShouldEnableHandler)shouldEnableHandler
{
    self.delegate = self;

    _shouldEnableHandler = nil;
    _shouldEnableHandler = [shouldEnableHandler copy];
}

@end
