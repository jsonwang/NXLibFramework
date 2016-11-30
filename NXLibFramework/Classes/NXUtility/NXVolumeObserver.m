//
//  NXVolumeObserver.m
//  NXLib
//
//  Created by AK on 14/10/31.
//  Copyright (c) 2014年 AK. All rights reserved.
//

#import "NXVolumeObserver.h"

@import AVFoundation;
#define VOLUME_CHANGED_KEY @"AVSystemController_SystemVolumeDidChangeNotification"
#define Volume_Click_Time 1.5

@interface NXVolumeObserver ()
{
    //监听音量键事件
    float _launchVolume;
    BOOL _isObservingVolumeButtons;

    NSTimer *_volumeTimer;

    //上一次改变音量时的时间
    NSTimeInterval _lastClickTime;

    MPVolumeView *_volumeView;
    UISlider *_volumeSlider;
    BOOL _isVideo;

    BOOL hasAddNoti;
    NSTimeInterval initTime;  //音量改变通知添加时间
}

@end

@implementation NXVolumeObserver

@synthesize delegate = _delegate;

+ (NXVolumeObserver *)sharedInstance;
{
    static NXVolumeObserver *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NXVolumeObserver alloc] init];
    });

    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(flipCameraEvents:)
//                                                     name:KNotificationFlipCamera
//                                                   object:nil];
        AVAudioSession *session = [AVAudioSession sharedInstance];
        BOOL success = NO;
        NSError *error = nil;
        success = [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
        if (!success)
        {
            NSLog(@"AVAudioSession error setting category:%@", [error userInfo]);
        }

        //        _launchVolume = [[MPMusicPlayerController applicationMusicPlayer] volume];
        success = [session overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:&error];

        if (success == NO)
        {
            NSLog(@"AVAudioSession error activating: %@", [error userInfo]);
        }
    }

    return self;
}

//翻转摄像头
- (void)flipCameraEvents:(NSNotification *)noti { initTime = [[NSDate date] timeIntervalSince1970]; }
/**
 *  声音大小监控
 *
 *  @param notification
 */
- (void)volumeChangeNotification:(NSNotification *)notification
{
    NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
    NSLog(@"声音改变通知 --- %f", nowTime - initTime);
    if (nowTime - initTime < 0.8f)
    {
        return;
    }
    static id sender = nil;
    if (sender == nil && notification.object)
    {
        sender = notification.object;
    }

    //  AudioVolume
    // AVSystemController_AudioVolumeNotificationParameter
    if (notification.object != sender ||
        [[notification.userInfo objectForKey:@"AudioVolume"] floatValue] == _launchVolume)
    {
        return;
    }

    if (_lastClickTime == 0 || (_lastClickTime > 0 && nowTime - _lastClickTime >= Volume_Click_Time))
    {  //连续点击时要判断两次点击间隔
        _lastClickTime = nowTime;
        //        delegate to tell start shoot
        if (self.delegate && [self.delegate respondsToSelector:@selector(volumeButtonDidClick:)])
        {
            [self.delegate volumeButtonDidClick:self];
        }
    }

    // TODO: 未完全适配 注释掉
    //    [[MPMusicPlayerController applicationMusicPlayer] setVolume:_launchVolume];

    // AVSystemController_AudioVolumeNotificationParameter    AudioVolume
    _launchVolume = [[notification.userInfo objectForKey:@"AudioVolume"] floatValue];

    _launchVolume = ((_launchVolume == 0) ? 0.05 : _launchVolume);
    _launchVolume = ((_launchVolume == 1) ? 0.95 : _launchVolume);

    [self setNewVolume:_launchVolume];
}
#pragma mark - volume action
/**
 *  开始监控音量
 */
- (void)startObserveVolumeChangeEvents
{
    if (!hasAddNoti)
    {
        initTime = [[NSDate date] timeIntervalSince1970];
        hasAddNoti = YES;
        [self performSelector:@selector(startObserve) withObject:nil afterDelay:Volume_Click_Time];
    }
}

#pragma mark - monitor delegate
//    开始监听声音事件
- (void)startObserve
{
    if (_isObservingVolumeButtons)
    {
        return;
    }
    [self createMPVolumeView];

    // TODO: 未完全适配 注释掉
    //    AudioSessionInitialize(NULL, NULL, NULL, NULL);
    //    SInt32 process = kAudioSessionCategory_PlayAndRecord;
    //    AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(process), &process);
    // set active统一放到pbjvision里面处理 by jb
    //    AudioSessionSetActive(YES);
    // FIXME: 讲上面 AudioToolbox 的 api 改成 AVFoundation 框架中的音频服
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    // TODO: 未完全适配 注释掉
    if (_volumeSlider == nil)
    {
        [self getMPVolumeValueSlider];
    }
    //    _launchVolume = [[MPMusicPlayerController applicationMusicPlayer] volume];
    _launchVolume = _volumeSlider.value;
    _launchVolume = ((_launchVolume == 0) ? 0.05 : _launchVolume);
    _launchVolume = ((_launchVolume == 1) ? 0.95 : _launchVolume);

    if (_launchVolume == 0.05 || _launchVolume == 0.95)
    {
        // TODO: 未完全适配 注释掉
        //        [[MPMusicPlayerController applicationMusicPlayer] setVolume:_launchVolume];
        [self setNewVolume:_launchVolume];
    }

    [self addNotification];

    _isObservingVolumeButtons = YES;
}
//延迟添加监听事件
- (void)addNotification
{
    initTime = [[NSDate date] timeIntervalSince1970];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(volumeChangeNotification:)
                                                 name:@"SystemVolumeDidChange"
                                               object:nil];

    //    [[NSNotificationCenter defaultCenter] addObserver:self
    //                                             selector:@selector(volumeChangeNotification:)
    //                                                 name:@"AVSystemController_SystemVolumeDidChangeNotification"
    //                                               object:nil];
}
/**
 *停止监听声音事件
 */
- (void)stopObserveVolumeChangeEvents
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startObserve) object:nil];
    //    [_volumeView removeFromSuperview];
    [self removeMPVolumeView];
    if (!_isObservingVolumeButtons)
    {
        return;
    }

    // SystemVolumeDidChange
    // AVSystemController_SystemVolumeDidChangeNotification
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SystemVolumeDidChange" object:nil];
    //???: 在 AVFundation 框架中暂时未找到移除方法
    // TODO: 未完全适配 注释掉
    //    AudioSessionRemovePropertyListenerWithUserData(kAudioSessionProperty_CurrentHardwareOutputVolume, NULL,
    //                                                   (__bridge void *)(self));
    // setactive放到pbjvision里面统一处理，需要先关掉所有音频相关，再setactiveNO，pbjvision里面有音频读写 by jb
    // AudioSessionSetActive(NO);

    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:NO error:nil];

    _isObservingVolumeButtons = NO;
    hasAddNoti = NO;
}

// TODO:以下代码是修复 [[MPMusicPlayerController applicationMusicPlayer] setVolume:_launchVolume] 在7.0之后被弃用的问题
// TODO: 统一使用改变 MPVolumeView的 slider value 来改变系统音量
- (void)createMPVolumeView
{
    if (nil == _volumeView)
    {
        CGRect frame = CGRectMake(-1000, -100, 100, 100);
        _volumeView = [[MPVolumeView alloc] initWithFrame:frame];
        _volumeView.hidden = NO;
        [[UIApplication sharedApplication].windows[0] addSubview:_volumeView];
    }
}

- (void)removeMPVolumeView
{
    if (_volumeView)
    {
        [_volumeSlider setThumbImage:nil forState:UIControlStateNormal];
        [_volumeSlider setMinimumTrackImage:nil forState:UIControlStateNormal];
        [_volumeSlider setMaximumTrackImage:nil forState:UIControlStateNormal];
        _volumeSlider = nil;

        [_volumeView removeFromSuperview];
        _volumeView = nil;
    }
}
- (void)getMPVolumeValueSlider
{
    if (_volumeView == nil)
    {
        [self createMPVolumeView];
    }

    for (UIView *view in [_volumeView subviews])
    {
        if ([view.class.description isEqualToString:@"MPVolumeSlider"])
        {
            _volumeSlider = (UISlider *)view;
            break;
        }
    }
}
- (void)setNewVolume:(CGFloat)newVolume
{
    if (_volumeSlider == nil)
    {
        [self getMPVolumeValueSlider];
    }

    if (newVolume >= 0.0f || newVolume <= 1.0f)
    {
        _volumeSlider.value = newVolume;
    }
}

- (void)dealloc
{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:KNotificationFlipCamera object:nil];

    [self stopObserveVolumeChangeEvents];
}
@end
