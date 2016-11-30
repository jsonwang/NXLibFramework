//
//  NXAdaptedSystem
//  NXlib
//
//  Created by AK on 5/4/14.
//  Copyright (c) 2014 AK. All rights reserved.
//

#import "NXAdaptedSystem.h"

/**
 *  @brief 检查是否iOS7+
 */
BOOL NXiOS7OrLater(void)
{
    static BOOL iOS7OrLater;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
        CGFloat systemVersion = [[[UIDevice currentDevice] systemVersion] doubleValue];
        if (systemVersion >= 7.f)
        {
            iOS7OrLater = YES;
        }
        else
        {
            iOS7OrLater = NO;
        }
#else
        iOS7OrLater = NO;
#endif
    });
    // NSLog(@"%@%@", @"iOS 7 Or Later : ", iOS7OrLater ? @"YES" : @"NO");
    return iOS7OrLater;
}

/**
 *  @brief 检查是否iOS8+
 */
extern BOOL NXiOS8OrLater(void)
{
    static BOOL iOS8OrLater;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
        CGFloat systemVersion = [[[UIDevice currentDevice] systemVersion] doubleValue];
        if (systemVersion >= 8.f)
        {
            iOS8OrLater = YES;
        }
        else
        {
            iOS8OrLater = NO;
        }
#else
        iOS8OrLater = NO;
#endif
    });
    // NSLog(@"%@%@", @"iOS 8 Or Later : ", iOS8OrLater ? @"YES" : @"NO");
    return iOS8OrLater;
}

/**
 *  @brief 获取适配的坐标(此坐标是基于iOS7+的坐标系)
 *
 *  @param x                x 坐标
 *  @param y                y 坐标
 *  @param width            宽度
 *  @param height           高度
 *  @param adaptedStatusBar 是否适配状态栏(YES, 高度在Y坐标计算范围内; 反之)
 *  @param adaptedNavBar    是否适配导航栏(YES, 高度在Y坐标计算范围内; 反之)
 *  @param adjustHeight     是否自适应高度
 *
 *  @return 适配的坐标
 */
CGRect CGRectAdapt(CGFloat x, CGFloat y, CGFloat width, CGFloat height, BOOL adaptedStatusBar, BOOL adaptedNavBar,
                   BOOL adjustHeight)
{
    BOOL iOS7OrLater = NXiOS7OrLater();

    CGRect rect;
    rect.origin.x = x;
    rect.size.width = width;
    if (iOS7OrLater)
    {
        rect.origin.y = y;
        rect.size.height = height;
    }
    else
    {
        if (adaptedStatusBar && !adaptedNavBar)
        {
            rect.origin.y = y - NX_STATUSBAR_HEIGHT;
        }
        else if (adaptedStatusBar && adaptedNavBar)
        {
            rect.origin.y = y - (NX_STATUSBAR_HEIGHT + NX_NAVIGATIONBAR_HEIGHT);
        }
        else
        {
            rect.origin.y = y;
        }
        if (adjustHeight && adaptedStatusBar && !adaptedNavBar)
        {
            rect.size.height = height + NX_STATUSBAR_HEIGHT;
        }
        else if (adjustHeight && adaptedStatusBar && adaptedNavBar)
        {
            rect.size.height = height + (NX_STATUSBAR_HEIGHT + NX_NAVIGATIONBAR_HEIGHT);
        }
        else
        {
            rect.size.height = height;
        }
    }
    return rect;
}

@implementation NXAdaptedSystem : NSObject

@end
