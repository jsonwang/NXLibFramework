//
//  NSDate+NXCategory.m
//  NXlib
//
//  Created by AK on 15/3/1.
//  Copyright (c) 2015年 AK. All rights reserved.
//

#import "NSDate+NXCategory.h"

#ifndef NSDateTimeAgoLocalizedStrings
#define NSDateTimeAgoLocalizedStrings(key)                                                                            \
    NSLocalizedStringFromTableInBundle(key, @"NSDateTimeAgo",                                                         \
                                       [NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath]                 \
                                                                    stringByAppendingPathComponent:@"NXlib.bundle"]], \
                                       nil)
#endif
@interface NSDate ()
@end

@implementation NSDate (NXCategory)

+ (NSString *)nx_getCurrDate
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    return [format stringFromDate:[NSDate date]];
}
+ (NSString *)nx_getDifferenceDateWithTimeInterval:(NSTimeInterval)secsToBeAdded
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];  // MAC10.8的系统注意“YY”要小写，否则会减一年，iOS暂时不区分
    NSDate *locationdate = [formatter dateFromString:[NSDate nx_getCurrDate]];
    NSDate *predate = [NSDate dateWithTimeInterval:secsToBeAdded sinceDate:locationdate];

    return [formatter stringFromDate:predate];
}

- (NSTimeInterval)nx_timestamp { return [self timeIntervalSince1970]; }
// 返回当前的 NSDateComponents
+ (NSDateComponents *)nx_currentComponentsWithData:(NSDate *)date
{
    NSCalendar *calendar = nil;
    NSUInteger flags = 0;
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute |
            NSCalendarUnitSecond | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekday | NSCalendarUnitWeekOfMonth |
            NSCalendarUnitWeekOfYear;
#else
    calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit |
            NSSecondCalendarUnit | NSWeekCalendarUnit | NSWeekdayCalendarUnit | NSWeekOfMonthCalendarUnit |
            NSWeekOfYearCalendarUnit;
#endif
    [calendar setTimeZone:[NSTimeZone systemTimeZone]];

    return [calendar components:flags fromDate:date];
}

#pragma mark - 年,月,日,小时,分钟,秒数
- (NSInteger)nx_year { return [NSDate nx_year:self]; }
- (NSInteger)nx_month { return [[NSDate nx_currentComponentsWithData:self] month]; }
- (NSInteger)nx_day { return [[NSDate nx_currentComponentsWithData:self] day]; }
- (NSInteger)nx_hour { return [[NSDate nx_currentComponentsWithData:self] hour]; }
- (NSInteger)nx_minute { return [[NSDate nx_currentComponentsWithData:self] minute]; }
- (NSInteger)nx_second { return [[NSDate nx_currentComponentsWithData:self] second]; }
+ (NSUInteger)nx_year:(NSDate *)date { return [[NSDate nx_currentComponentsWithData:date] year]; }
+ (NSUInteger)nx_month:(NSDate *)date { return [[NSDate nx_currentComponentsWithData:date] month]; }
+ (NSUInteger)nx_day:(NSDate *)date { return [[NSDate nx_currentComponentsWithData:date] day]; }
+ (NSUInteger)nx_hour:(NSDate *)date { return [[NSDate nx_currentComponentsWithData:date] hour]; }
+ (NSUInteger)nx_minute:(NSDate *)date { return [[NSDate nx_currentComponentsWithData:date] minute]; }
+ (NSUInteger)nx_second:(NSDate *)date { return [[NSDate nx_currentComponentsWithData:date] second]; }
#pragma mark - 周几 1,2,3
- (NSInteger)nx_weekOfDay { return [NSDate nx_weekOfDayWithDate:self]; }
+ (NSInteger)nx_weekOfDayWithDate:(NSDate *)date { return [[NSDate nx_currentComponentsWithData:date] weekday]; }
#pragma mark - 当月是第几周
- (NSInteger)nx_weekOfMonth { return [NSDate nx_weekOfMonthWithDate:self]; }
+ (NSInteger)nx_weekOfMonthWithDate:(NSDate *)date { return [[NSDate nx_currentComponentsWithData:date] weekOfMonth]; }
#pragma mark - 当年第几周
- (NSInteger)nx_weekOfYear { return [NSDate nx_weekOfYearWithDate:self]; }
+ (NSInteger)nx_weekOfYearWithDate:(NSDate *)date { return [[NSDate nx_currentComponentsWithData:date] weekOfYear]; }
#pragma mark - 取星期的字符串
- (NSString *)nx_weekStr { return [NSDate nx_weekStrWithDate:self]; }
+ (NSString *)nx_weekStrWithDate:(NSDate *)date
{
    NSArray *arrWeek = [NSArray
        arrayWithObjects:@"Sunday", @"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday", nil];

    int week = MIN(MAX(0, [NSDate nx_weekOfDayWithDate:date] - 1), arrWeek.count - 1);

    return [arrWeek objectAtIndex:week];
}
- (NSString *)nx_simplifyWeekStr { return [NSDate nx_simplifyWeekStrWithDate:self]; }
+ (NSString *)nx_simplifyWeekStrWithDate:(NSDate *)date
{
    return [[NSDate nx_weekStrWithDate:date] substringToIndex:3];
}
#pragma mark - 取月份的字符串
- (NSString *)nx_monthStr { return [NSDate nx_monthStrWithDate:self]; }
+ (NSString *)nx_monthStrWithDate:(NSDate *)date
{
    NSArray *arrMonth = [NSArray arrayWithObjects:@"January", @"February", @"March", @"April", @"May", @"June", @"July",
                                                  @"August", @"September", @"October", @"November", @"December", nil];

    int month = MIN(MAX(0, [[NSDate nx_currentComponentsWithData:date] month] - 1), arrMonth.count - 1);

    return [arrMonth objectAtIndex:month];
}
- (NSString *)nx_simplifyMonthStr { return [NSDate nx_simplifyMonthStrWithDate:self]; }
+ (NSString *)nx_simplifyMonthStrWithDate:(NSDate *)date
{
    return [[self nx_monthStrWithDate:date] substringToIndex:3];
}

- (NSInteger)nx_numberOfDaysInMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange daysRang = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self];
    return daysRang.length;
}

- (BOOL)nx_isLeapYear
{
    NSInteger year = self.nx_year;
    if ((0 == year % 4 && 0 != year % 100) || (0 == year % 400))
    {
        return YES;
    }
    return NO;
}

- (NSString *)nx_stringWithFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateFormat:format];
    NSString *dateString = [dateFormatter stringFromDate:self];
#if !__has_feature(objc_arc)
    [dateFormatter release];
#endif
    return dateString;
}

- (BOOL)nx_isSameDay:(NSDate *)anotherDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 =
        [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self];
    NSDateComponents *components2 =
        [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:anotherDate];
    return ([components1 year] == [components2 year] && [components1 month] == [components2 month] &&
            [components1 day] == [components2 day]);
}

/**
 *  @brief 日期相隔多少天
 */
- (NSInteger)nx_daysSinceDate:(NSDate *)anotherDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSDayCalendarUnit;
    NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:self toDate:anotherDate options:0];
    return [dateComponents day];
}

- (NSString *)nx_timeAgo
{
    NSDate *now = [NSDate date];
    double deltaSeconds = fabs([self timeIntervalSinceDate:now]);
    double deltaMinutes = deltaSeconds / 60.0f;

    int minutes;

    if (deltaSeconds < 5)
    {
        return NSDateTimeAgoLocalizedStrings(@"Just now");
    }
    else if (deltaSeconds < 60)
    {
        return [self stringFromFormat:@"%%d %@seconds ago" withValue:deltaSeconds];
    }
    else if (deltaSeconds < 120)
    {
        return NSDateTimeAgoLocalizedStrings(@"A minute ago");
    }
    else if (deltaMinutes < 60)
    {
        return [self stringFromFormat:@"%%d %@minutes ago" withValue:deltaMinutes];
    }
    else if (deltaMinutes < 120)
    {
        return NSDateTimeAgoLocalizedStrings(@"An hour ago");
    }
    else if (deltaMinutes < (24 * 60))
    {
        minutes = (int)floor(deltaMinutes / 60);
        return [self stringFromFormat:@"%%d %@hours ago" withValue:minutes];
    }
    else if (deltaMinutes < (24 * 60 * 2))
    {
        return NSDateTimeAgoLocalizedStrings(@"Yesterday");
    }
    else if (deltaMinutes < (24 * 60 * 7))
    {
        minutes = (int)floor(deltaMinutes / (60 * 24));
        return [self stringFromFormat:@"%%d %@days ago" withValue:minutes];
    }
    else if (deltaMinutes < (24 * 60 * 14))
    {
        return NSDateTimeAgoLocalizedStrings(@"Last week");
    }
    else if (deltaMinutes < (24 * 60 * 31))
    {
        minutes = (int)floor(deltaMinutes / (60 * 24 * 7));
        return [self stringFromFormat:@"%%d %@weeks ago" withValue:minutes];
    }
    else if (deltaMinutes < (24 * 60 * 61))
    {
        return NSDateTimeAgoLocalizedStrings(@"Last month");
    }
    else if (deltaMinutes < (24 * 60 * 365.25))
    {
        minutes = (int)floor(deltaMinutes / (60 * 24 * 30));
        return [self stringFromFormat:@"%%d %@months ago" withValue:minutes];
    }
    else if (deltaMinutes < (24 * 60 * 731))
    {
        return NSDateTimeAgoLocalizedStrings(@"Last year");
    }

    minutes = (int)floor(deltaMinutes / (60 * 24 * 365));
    return [self stringFromFormat:@"%%d %@years ago" withValue:minutes];
}

- (NSString *)stringFromFormat:(NSString *)format withValue:(NSInteger)value
{
    NSString *localeFormat = [NSString stringWithFormat:format, [self getLocaleFormatUnderscoresWithValue:value]];

    return [NSString stringWithFormat:NSDateTimeAgoLocalizedStrings(localeFormat), value];
}
- (NSString *)getLocaleFormatUnderscoresWithValue:(double)value
{
    //获取当前使用语言 @see http://www.ruanyifeng.com/blog/2008/02/codes_for_language_names.html

    // Russian (ru 俄语)
    if ([NX_CURRENT_LANGUAGE hasPrefix:@"ru"] || [NX_CURRENT_LANGUAGE hasPrefix:@"uk"])
    {
        int XY = (int)floor(value) % 100;
        int Y = (int)floor(value) % 10;

        if (Y == 0 || Y > 4 || (XY > 10 && XY < 15)) return @"";
        if (Y > 1 && Y < 5 && (XY < 10 || XY > 20)) return @"_";
        if (Y == 1 && XY != 11) return @"__";
    }

    // Add more languages here, which are have specific translation rules...

    return @"";
}

@end
