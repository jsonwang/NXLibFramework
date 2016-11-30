//
//  NXDebugWindow.m
//  YOSticker
//
//  Created by AK on 16/7/19.
//  Copyright © 2016年 Catch app. All rights reserved.
//

#import "NXDebugWindow.h"

@implementation NXDebugWindow

- (id)initWithFrame:(CGRect)frame delegate:(id)delegate
{
    if (self = [super initWithFrame:frame])
    {
        self.rootViewController = [[UIViewController alloc] init];
        self.backgroundColor = [UIColor yellowColor];
        [self initUI];

        self.windowLevel = UIWindowLevelStatusBar + 199.0f;
    }

    return self;
}
- (void)initUI
{
    UIButton *_iconButton = [[UIButton alloc] initWithFrame:CGRectMake(40, 40, 40, 40)];
    _iconButton.backgroundColor = [UIColor redColor];
    _iconButton.adjustsImageWhenHighlighted = YES;
    [_iconButton setImage:[UIImage imageNamed:@"btn_floatjiazan"] forState:UIControlStateNormal];

    [_iconButton addTarget:self action:@selector(onDetailedWindow:) forControlEvents:UIControlEventTouchUpInside];
    [self.rootViewController.view addSubview:_iconButton];

    [_iconButton addTarget:self action:@selector(dragMoving:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [_iconButton addTarget:self
                    action:@selector(dragEnded:withEvent:)
          forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
}

#pragma mark - ButtonClicked
- (void)onDetailedWindow:(id)sender { NSLog(@"btn onclick"); }
- (void)dragMoving:(UIControl *)c withEvent:ev { c.center = [[[ev allTouches] anyObject] locationInView:self]; }
- (void)dragEnded:(UIControl *)c withEvent:ev { c.center = [[[ev allTouches] anyObject] locationInView:self]; }
@end
