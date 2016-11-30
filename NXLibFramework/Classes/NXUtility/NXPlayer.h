//
//  NXPlayer.h
//  NXlib
//
//  Created by AK on 15/12/20.
//  Copyright © 2015年 AK. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

/*
 [NXPlayer playMP3:@"Westlife - My Love" pathType:PathTypeFromDefault
 completion: ^{
 // play finish do something ...
 }];


 [NXPlayer
 playMP3:@"https://www.dropbox.com/s/xbww361mt0dpocs/Westlife%20-%20My%20Love.mp3?dl=1"
 pathType:PathTypeFromURL completion: ^{
 // play finish do something ...
 }];
 */

typedef enum {
  PathTypeFromDefault,
  PathTypeFromDocument,
  PathTypeFromResource,
  PathTypeFromURL
} PathType;

typedef void (^PlayFinishCallBackBlock)();

@interface NXPlayer : NSObject

/**
 @abstract 初始化音乐播放器
 @discussion 播放 Document, Resource 下的 MP3 音乐
 @param mp3Name MP3 资源名字不用加 "."
 @param pathType 路径类型, PathTypeFromBoth 先从 Document 找，沒有找到在从
 Resource 里面找
 @param completion 一首 MP3 播放完成后的回调
 */
+ (void)playMP3:(NSString *)mp3Name
       pathType:(PathType)pathType
     completion:(PlayFinishCallBackBlock)completion;

/**
 @abstract 快进音乐
 @discussion 手动设置音乐播放进度
 @param time 单位 sec
 */
+ (void)setCurrentTime:(int)time;

/**
 @abstract 播放音乐
 */
+ (void)play;

/**
 @abstract 暂停音乐
 */
+ (void)pause;

/**
 @abstract 取得音乐当前播放进度
 @returns 单位 sec
 */
+ (int)currentTime;

/**
 @abstract 取得音乐剩余进度
 @returns 单位 sec
 */
+ (int)duration;

/**
 @abstract 取得音乐是否正在播放
 @returns YES 为正在播放中
 */
+ (BOOL)isPlaying;

@end
