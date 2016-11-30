//
//  SCDateManager.h
//  NXlib
//
//  Created by AK on 3/6/14.
//  Copyright (c) 2014 AK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NXDateManager : NSObject

+ (NXDateManager *)sharedInstance;

- (NSString *)stringByConvertFromDate:(NSDate *)date format:(NSString *)format;
- (NSDate *)dateByConvertFromString:(NSString *)string format:(NSString *)format;
- (NSString *)dateWithTimeIntervalSince1970:(NSTimeInterval)secs format:(NSString *)format;

@end
