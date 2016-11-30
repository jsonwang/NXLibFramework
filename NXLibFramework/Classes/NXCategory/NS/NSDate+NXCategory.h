//
//  NSDate+NXCategory.h
//  NXlib
//
//  Created by AK on 15/3/1.
//  Copyright (c) 2015年 AK. All rights reserved.
//

#define kNXFW_SECOND_MINUTE 60
#define kNXFW_SECOND_HOUR 3600
#define kNXFW_SECOND_DAY 86400
#define kNXFW_SECOND_WEEK 604800
#define kNXFW_SECOND_YEAR 31556926

@interface NSDate (NXCategory)

/**
 *  取当前的年月日
 *
 *  @return 年月日str e.g. 2016-09-02
 */
+ (NSString *)nx_getCurrDate;

/**
 *  计算和当前日期相差多少S 的日期
 *
 *  @param secsToBeAdded 相差秒数 e.g. 明天:24 * 60 * 60 , 昨天:-24 * 60 * 60
 *
 *  @return 预计日期 YYYY-MM-dd
 */
+ (NSString *)nx_getDifferenceDateWithTimeInterval:(NSTimeInterval)secsToBeAdded;

/**
 *  按指定data 返回 NSDateComponents
 *
 *  @param data 当前日期
 *
 *  @return NSDateComponents
 */
+ (NSDateComponents *)nx_currentComponentsWithData:(NSDate *)data;

/**
 *  取当前时间戳
 *
 *  @return 时间戳 e.g. 1472829997
 */
- (NSTimeInterval)nx_timestamp;

#pragma mark -
//返回当前时间的,年,月,日,小时,分钟,秒数
- (NSInteger)nx_year;
- (NSInteger)nx_month;
- (NSInteger)nx_day;
- (NSInteger)nx_hour;
- (NSInteger)nx_minute;
- (NSInteger)nx_second;
//返回指定时间的,年,月,日,小时,分钟,秒数
+ (NSUInteger)nx_year:(NSDate *)date;
+ (NSUInteger)nx_month:(NSDate *)date;
+ (NSUInteger)nx_day:(NSDate *)date;
+ (NSUInteger)nx_hour:(NSDate *)date;
+ (NSUInteger)nx_minute:(NSDate *)date;
+ (NSUInteger)nx_second:(NSDate *)date;

/**
 *  取当前日期是星期几 参数是当前日期|指定日期
 *
 *  @return 星期
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSInteger)nx_weekOfDay;
+ (NSInteger)nx_weekOfDayWithDate:(NSDate *)date;
/**
 *  取当月第几周 参数是当前日期|指定日期
 *
 *  @return
 */
- (NSInteger)nx_weekOfMonth;
+ (NSInteger)nx_weekOfMonthWithDate:(NSDate *)date;
/**
 *  取当年第几周 参数是当前日期|指定日期
 *
 *  @return
 */
- (NSInteger)nx_weekOfYear;
+ (NSInteger)nx_weekOfYearWithDate:(NSDate *)date;

/**
 *  当前日期星期string(全写) 参数是当前日期|指定日期
 *
 *  @return 星期 e.g. Sunday
 */
- (NSString *)nx_weekStr;
+ (NSString *)nx_weekStrWithDate:(NSDate *)date;
/**
 *  当前日期星期string(缩写) 参数是当前日期|指定日期
 *
 *  @return 星期 e.g. Sun
 */
- (NSString *)nx_simplifyWeekStr;
+ (NSString *)nx_simplifyWeekStrWithDate:(NSDate *)date;

/**
 *  当前日期月份string(全写) 参数是当前日期|指定日期
 *
 *  @return 月份 e.g. January
 */
- (NSString *)nx_monthStr;
+ (NSString *)nx_monthStrWithDate:(NSDate *)date;

/**
 *  当前日期月份string(缩写) 参数是当前日期|指定日期
 *
 *  @return 月份 e.g. Jan
 */
- (NSString *)nx_simplifyMonthStr;
+ (NSString *)nx_simplifyMonthStrWithDate:(NSDate *)date;

/**
 *  获取月份的天数
 *
 *  @return 天数 e.g. 30
 */
- (NSInteger)nx_numberOfDaysInMonth;

/**
 *  判断是否闰年
 *
 *  @return 返回YES 闰年; NO 平年
 */
- (BOOL)nx_isLeapYear;

/**
 *  当前时间按指定格式转字符串
 *
 *  @param format 时间格式 YYYY-MM-dd hh:mm:ss
 *
 *  @return 转换后字符 2016-09-02 04:06:06
 */
- (NSString *)nx_stringWithFormat:(NSString *)format;

/**
 *  判断某个NSDate和当前日间是否是同一天
 *
 *  @param anotherDate 比对date
 *
 *  @return YES为同一天
 */
- (BOOL)nx_isSameDay:(NSDate *)anotherDate;

/**
 *  两个日期相隔多少天
 *
 *  @param anotherDate 比对date
 *
 *  @return 相隔天数
 */
- (NSInteger)nx_daysSinceDate:(NSDate *)anotherDate;

/**
 *  根据两个时间 时间间隔str ,支持英文和简体中文
 *
 *  @return e.g. < 5min Just now
 */
- (NSString *)nx_timeAgo;

@end
