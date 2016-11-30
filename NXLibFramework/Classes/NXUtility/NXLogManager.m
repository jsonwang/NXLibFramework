//
//  NXLogManager.m
//  YOSticker
//
//  Created by AK on 16/7/15.
//  Copyright © 2016年 Catch app. All rights reserved.
//

#import "NXLogManager.h"

#include <asl.h>

@interface NXLogManager ()

@end

@implementation NXLogManager

+ (NSMutableArray<SystemLogMessage *> *)allLogMessagesForCurrentProcess
{
    asl_object_t query = asl_new(ASL_TYPE_QUERY);

    NSString *pidString = [NSString stringWithFormat:@"%d", [[NSProcessInfo processInfo] processIdentifier]];
    asl_set_query(query, ASL_KEY_PID, [pidString UTF8String], ASL_QUERY_OP_EQUAL);

    aslresponse response = asl_search(NULL, query);
    aslmsg aslMessage = NULL;

    NSMutableArray *logMessages = [NSMutableArray array];

    //兼容 7.0设备
    if ([[UIDevice currentDevice].systemVersion doubleValue] <= 8.0)
    {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        while ((aslMessage = aslresponse_next(response)))
        {
            [logMessages addObject:[NXLogManager logMessageFromASLMessage:aslMessage]];
        }
        aslresponse_free(response);
#pragma GCC diagnostic pop
    }
    else
    {
        while ((aslMessage = asl_next(response)))
        {
            [logMessages addObject:[NXLogManager logMessageFromASLMessage:aslMessage]];
        }
        asl_release(response);
    }

    return logMessages;
}

+ (SystemLogMessage *)logMessageFromASLMessage:(aslmsg)aslMessage
{
    SystemLogMessage *logMessage = [[SystemLogMessage alloc] init];

    const char *timestamp = asl_get(aslMessage, ASL_KEY_TIME);
    if (timestamp)
    {
        NSTimeInterval timeInterval = [@(timestamp) integerValue];
        const char *nanoseconds = asl_get(aslMessage, ASL_KEY_TIME_NSEC);
        if (nanoseconds)
        {
            timeInterval += [@(nanoseconds) doubleValue] / NSEC_PER_SEC;
        }
        logMessage.timeInterval = timeInterval;
        logMessage.date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    }

    const char *sender = asl_get(aslMessage, ASL_KEY_SENDER);
    if (sender)
    {
        logMessage.sender = @(sender);
    }

    const char *messageText = asl_get(aslMessage, ASL_KEY_MSG);
    if (messageText)
    {
        logMessage.messageText = @(messageText);  // NSLog写入的文本内容
    }

    const char *messageID = asl_get(aslMessage, ASL_KEY_MSG_ID);
    if (messageID)
    {
        logMessage.messageID = [@(messageID) longLongValue];
    }

    return logMessage;
}
@end

@implementation SystemLogMessage
@end
