//
//  NXVolumeObserver.h
//  NXlib
//
//  Created by AK on 14/10/31.
//  Copyright (c) 2014年 AK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AudioToolbox/AudioToolbox.h>
#import <UIKit/UIKit.h>

@class NXVolumeObserver;

@protocol NXVolumeObserverDelegate<NSObject>

- (void)volumeButtonDidClick:(NXVolumeObserver *)button;

@end

@interface NXVolumeObserver : NSObject
{
}

@property(nonatomic, strong) id<NXVolumeObserverDelegate> delegate;

+ (NXVolumeObserver *)sharedInstance;

- (void)startObserveVolumeChangeEvents;

- (void)stopObserveVolumeChangeEvents;

@end
