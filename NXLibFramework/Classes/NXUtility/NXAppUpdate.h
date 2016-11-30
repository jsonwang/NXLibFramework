//
//  NXAppUpdate.h
//  NXLib
//
//  Created by AK on 14-2-19.
//  Copyright (c) 2014年 AK. All rights reserved.
//

#include "NXObject.h"

extern NSString *const NXVersionManagerLanguageEnglish;
extern NSString *const NXVersionManagerLanguageChineseSimplified;
extern NSString *const NXVersionManagerLanguageChineseTraditional;

typedef NS_ENUM(NSUInteger, NXVersionAlertType)
{
    NXVersionAlertTypeDefault,
    NXVersionAlertTypeSkip,
    NXVersionAlertTypeForce,
};

@protocol NXAppUpdateDelegate<NSObject>

@optional
- (void)versionManagerDidPresentAlert;
- (void)versionManagerDidLaunchAppStore;
- (void)versionManagerDidSkipVersion;
- (void)versionManagerDidCancel;

@end

@interface NXAppUpdate : NXObject
{
}

@property(nonatomic, weak) id<NXAppUpdateDelegate> delegate;

@property(nonatomic, retain) NSString *appID;

@property(nonatomic, retain) NSString *appName;

@property(nonatomic, retain) NSString *countryCode;

@property(nonatomic, assign) NXVersionAlertType alertType;

+ (NXAppUpdate *)sharedInstance;

- (void)checkVersion;

- (void)checkVersionDaily;

- (void)checkVersionWeekly;

@end
