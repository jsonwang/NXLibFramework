//
//  NXAppReview.h
//  NXlib
//
//  Created by AK on 14-5-22.
//  Copyright (c) 2014年 AK. All rights reserved.
//

/**
 *  功能 APP 评论
 *	XXXX TODO 不同IOS系统版本
 *
 */

#import <Foundation/Foundation.h>

@class NXAppReview;
@protocol appReviewDelegate<NSObject>

@optional

- (void)appReviewWillPresentModalView:(NXAppReview *)appirater animated:(BOOL)animated;
- (void)appReviewDidDismissModalView:(NXAppReview *)appirater animated:(BOOL)animated;

@end

@interface NXAppReview : NSObject
{
    id<appReviewDelegate> delegate;
}

@property(nonatomic, strong) id<appReviewDelegate> delegate;

+ (NXAppReview *)sharedInstance;

- (void)rateApp;

@end
