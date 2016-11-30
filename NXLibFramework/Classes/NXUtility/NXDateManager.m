//
//  SCDateManager.m
//  NXlib
//
//  Created by AK on 3/6/14.
//  Copyright (c) 2014 AK. All rights reserved.
//

#import "NXDateManager.h"

#import "NXConfig.h"

@interface NXDateManager ()

@property(nonatomic, strong) NSDateFormatter *dateForrmatter;

@end

@implementation NXDateManager

NXSINGLETON(NXDateManager);

- (id)init
{
    if (self = [super init])
    {
        _dateForrmatter = [[NSDateFormatter alloc] init];
        [_dateForrmatter setLocale:[NSLocale currentLocale]];
        [_dateForrmatter setTimeZone:[NSTimeZone localTimeZone]];
    }
    return self;
}

- (NSString *)stringByConvertFromDate:(NSDate *)date format:(NSString *)format
{
    [_dateForrmatter setDateFormat:format];
    NSString *dateString = [_dateForrmatter stringFromDate:date];
    return dateString;
}

- (NSDate *)dateByConvertFromString:(NSString *)string format:(NSString *)format
{
    [_dateForrmatter setDateFormat:format];
    NSDate *date = [_dateForrmatter dateFromString:string];
    return date;
}

- (NSString *)dateWithTimeIntervalSince1970:(NSTimeInterval)secs format:(NSString *)format
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:secs];
    return [self stringByConvertFromDate:date format:format];
}

@end
