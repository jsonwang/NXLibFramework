//
//  NXFramework.h
//  NXlib
//
//  Created by AK on 15/3/1.
//  Copyright (c) 2015年 AK. All rights reserved.
//

//当前版本0.1

/*
 使用说明 XXXX 非常重要
 要导入
 1,libsqlite3.0.dylib FMDB使用
 2,EventKit.framework NXDevicePermission 设置权限要使用
 */

#ifndef NXlib_NXFramework_h
#define NXlib_NXFramework_h

//#ifndef __IPHONE_10_0
//#warning "This project uses features only available in iPhone SDK 10.0 and later."
//#endif

#import <Foundation/Foundation.h>

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>

#elif TARGET_OS_MAC
#import <AppKit/AppKit.h>
#import <Cocoa/Cocoa.h>

#endif

// -------------------------- Common -------------------------- //

#import "NXConfig.h"
#import "NXMath.h"
//#import "NXModel.h"
//#import "NXNSJSONSerialization.h"

// -------------------------- NXFoundation -------------------------- //
//#import "NXNSJSONSerialization.h"

// -------------------------- Adapted -------------------------- //
#import "NXAdaptedDevice.h"
#import "NXAdaptedSystem.h"

// -------------------------- Utility -------------------------- //
#import "NXSystemInfo.h"
//#import "NXPlayer.h"
#import "NXReachability.h"
//#import "Aspects.h"
#import "NXSpotlight.h"
#import "NXFileManager.h"
#import "NXArchivedManager.h"
#import "NXDevicePermission.h"
#import "NXLogManager.h"
#import "NXSendMail.h"
#import "NXMuteSwitch.h"

// -------------------------- autoLayout -------------------------- //
#import "UIView+SDAutoLayout.h"

// -------------------------- Category -------------------------- //
#import "NSObject+NXCategory.h"
#import "NSString+NXCategory.h"
#import "NSData+NXCategory.h"
#import "NSDate+NXCategory.h"
#import "NSDictionary+NXCategory.h"
#import "NSArray+NXCategory.h"
#import "NSURL+NXCategory.h"
#import "NSUserDefaults+NXCategory.h"
//
//
#import "UIAlertView+NXAddition.h"
#import "UIView+NXCategory.h"
//#import "UIViewController+swizzling.h"
#import "UIImage+NXCategory.h"
#import "UIAlertView+NXAddition.h"
#import "UIViewController+NXAddiction.h"
#import "NXUIDevice-Hardware.h"
#import "UIControl+NXCategory.h"

// -------------------------- views -------------------------- //
#import "NXCreateUITool.h"

//#import "MJRefresh.h"

// -------------------------- network -------------------------- //
//#import "AFNetworking.h"

// -------------------------- debug -------------------------- //
#import "NXLog.h"
//#import "MLeaksFinder.h" 内存泄露实现监测 会在泄露时APP crash 在 release 时一定要关闭

#endif
