//
//  NXMuteSwitch.h
//  Philm
//
//  Created by AK on 16/9/9.
//  Copyright © 2016年 yoyo. All rights reserved.
//

/**
 *  监测静音按键是否打开

 e.g.

 [[NXMuteSwitch sharedInstance] detectMuteSwitch:^(BOOL isMuted) {

 if (isMuted)
 {
    NSLog(@"声音关闭");
 }
 else
 {
    NSLog(@"声音打开");
 }

 }];
 */

#import <Foundation/Foundation.h>

typedef void (^SharkfoodMuteSwitchDetectorBlock)(BOOL silent);

@interface NXMuteSwitch : NSObject

+ (NXMuteSwitch *)sharedInstance;

@property(nonatomic, readonly) BOOL isMute;
@property(nonatomic, copy) SharkfoodMuteSwitchDetectorBlock silentNotify;

- (void)detectMuteSwitch;
@end
