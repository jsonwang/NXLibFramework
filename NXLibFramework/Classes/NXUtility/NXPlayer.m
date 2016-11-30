//
//  NXPlayer.m
//  NXlib
//
//  Created by AK on 15/12/20.
//  Copyright © 2015年 AK. All rights reserved.
//

#import "NXPlayer.h"

#define AVAudioPlayerIsNull(obj)                                                      \
    if (!obj)                                                                         \
    {                                                                                 \
        NSLog((@"%s [Line %d] AVAudioPlayer%@"), __PRETTY_FUNCTION__, __LINE__, obj); \
    }

@interface NXPlayer ()

@property(nonatomic, strong) AVAudioPlayer *audioPlayer;
@property(nonatomic, strong) PlayFinishCallBackBlock completion;

@end

@implementation NXPlayer

#pragma mark - class method

+ (void)playMP3:(NSString *)mp3Name pathType:(PathType)pathType completion:(PlayFinishCallBackBlock)completion
{
    [[NXPlayer shared] playMP3:mp3Name pathType:pathType completion:completion];
}

+ (void)setCurrentTime:(int)time { [[NXPlayer shared] setCurrentTime:time]; }

+ (void)play { [[NXPlayer shared] play]; }

+ (void)pause { [[NXPlayer shared] pause]; }

+ (int)currentTime { return [[NXPlayer shared] currentTime]; }

+ (int)duration { return [[NXPlayer shared] duration]; }

+ (BOOL)isPlaying { return [[NXPlayer shared] isPlaying]; }

#pragma mark - private method

#pragma mark * init

+ (NXPlayer *)shared
{
    static NXPlayer *shared = nil;
    if (!shared)
    {
        shared = [[self alloc] init];
    }
    return shared;
}

#pragma mark * AVAudioPlayer

- (void)playMP3:(NSString *)mp3Name pathType:(PathType)pathType completion:(PlayFinishCallBackBlock)completion
{
    self.completion = completion;
    NSString *path = [self pathMp3Name:mp3Name fromDocument:pathType];
    if (path)
    {
        if (pathType == PathTypeFromURL)
        {
            // URL
            NSURL *url = [NSURL URLWithString:path];
            NSData *data = [NSData dataWithContentsOfURL:url];
            self.audioPlayer = [[AVAudioPlayer alloc] initWithData:data error:NULL];
        }
        else
        {
            // File
            self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
        }

        //设置静音模式下不播放
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:nil];
        AVAudioSession *session = [AVAudioSession sharedInstance];

        [session setActive:YES error:nil];

        self.audioPlayer.delegate = (id<AVAudioPlayerDelegate>)self;
        self.audioPlayer.volume = 0.1;
        [self.audioPlayer setNumberOfLoops:-1];
        [self.audioPlayer prepareToPlay];
        [self.audioPlayer play];
    }
    else
    {
        self.completion();
    }
}

- (BOOL)isPlaying { return self.audioPlayer.isPlaying; }

- (void)setCurrentTime:(int)time { self.audioPlayer.currentTime = time; }

- (void)play { [self.audioPlayer play]; }

- (void)pause { [self.audioPlayer pause]; }

- (int)currentTime { return self.audioPlayer.currentTime; }

- (int)duration { return self.audioPlayer.duration; }

#pragma mark * AVAudioPlayer delegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag { self.completion(); }

#pragma mark * fetch file

- (NSString *)pathMp3Name:(NSString *)mp3Name fromDocument:(PathType)pathType
{
    NSString *path;
    switch (pathType)
    {
        case PathTypeFromDefault:
        {
            path = [self pathMp3Name:mp3Name fromDocument:PathTypeFromDocument];
            if (!path.length)
            {
                path = [self pathMp3Name:mp3Name fromDocument:PathTypeFromResource];
            }
            break;
        }

        case PathTypeFromDocument:
        {
            NSArray *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            path = [documentPath[0] stringByAppendingString:[NSString stringWithFormat:@"/%@.mp3", mp3Name]];
            break;
        }

        case PathTypeFromResource:
        {
            path = [[NSBundle mainBundle] pathForResource:mp3Name ofType:@".mp3"];
            break;
        }

        case PathTypeFromURL:
        {
            return mp3Name;
        }
    }

    if (![self isFindMP3:path])
    {
        path = [NSString new];
    }
    return path;
}

#pragma mark * misc

- (BOOL)isFindMP3:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:path] ? YES : NO;
}

@end
