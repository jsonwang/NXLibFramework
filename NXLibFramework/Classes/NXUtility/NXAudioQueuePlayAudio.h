//
//  NXAudioQueuePlayAudio.h
//  NXlib
//
//  Created by 北京-AK on 14/11/18.
//  Copyright (c) 2014年 AK. All rights reserved.
//

// 1, link AudioToolbox.framework
// 2, call [[NXAudioQueuePlayAudio alloc]initWithAudio:@"audioFilePath"];
//功能使用audioQueue 播放声音文件 raw pcm data wav mp3, acc

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AudioToolbox/AudioFile.h>
#define NXAudioQueuePlayAudio_NUM_BUFFERS 3

@interface NXAudioQueuePlayAudio : NSObject
{
    //播放音频文件ID
    AudioFileID audioFile;
    //音频流描述对象
    AudioStreamBasicDescription dataFormat;
    //音频队列
    AudioQueueRef queue;
    SInt64 packetIndex;
    UInt32 numPacketsToRead;
    UInt32 bufferByteSize;
    AudioStreamPacketDescription *packetDescs;
    AudioQueueBufferRef buffers[NXAudioQueuePlayAudio_NUM_BUFFERS];
}

//定义队列为实例属性
@property AudioQueueRef queue;
//播放方法定义
- (id)initWithAudio:(NSString *)path;
//定义缓存数据读取方法
- (void)audioQueueOutputWithQueue:(AudioQueueRef)audioQueue queueBuffer:(AudioQueueBufferRef)audioQueueBuffer;
- (UInt32)readPacketsIntoBuffer:(AudioQueueBufferRef)buffer;
//定义回调(Callback)函数
// static void BufferCallack(void *inUserData,AudioQueueRef inAQ,
//						  AudioQueueBufferRef buffer);

@end
