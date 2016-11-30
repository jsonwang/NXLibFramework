//
//  NXNSJSONSerialization.m
//
//  Created by AK on 15/2/28.
//  Copyright (c) 2015年 AK. All rights reserved.
//
#import "NXNSJSONSerialization.h"

@implementation NXNSJSONSerialization

+ (id)objectFromData:(NSData *)data { return [self.class objectFromData:data error:nil]; }

+ (NSData *)dataFromObject:(id)object { return [self.class dataFromObject:object error:nil]; }

+ (id)objectFromData:(NSData *)data error:(NSError **)error
{
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:error];
}

+ (NSData *)dataFromObject:(id)object error:(NSError **)error
{
    return [NSJSONSerialization dataWithJSONObject:object options:0 error:error];
}

+ (id)objectFromString:(NSString *)string { return [self.class objectFromString:string error:nil]; }

+ (NSString *)stringFromObject:(id)object { return [self.class stringFromObject:object error:nil]; }

+ (id)objectFromString:(NSString *)string error:(NSError *__autoreleasing *)error
{
    NSData *JSONData = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [self.class objectFromData:JSONData error:error];
}

+ (NSString *)stringFromObject:(id)object error:(NSError *__autoreleasing *)error
{
    NSData *JSONData = [self.class dataFromObject:object error:error];
    if (*error)
    {
        return nil;
    }

    NSString *JSONString = [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
    return JSONString;
}

@end
