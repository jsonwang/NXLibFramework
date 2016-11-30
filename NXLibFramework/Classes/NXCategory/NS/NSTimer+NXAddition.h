//
//  NSTimer+NXAddition.h
//  ZhongTouBang
//
//  Created by AK on 8/20/14.
//  Copyright (c) 2014 AK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (NXAddition)

- (void)nx_pause;
- (void)nx_resume;
- (void)nx_resumeAfterTimeInterval:(NSTimeInterval)interval;

@end
