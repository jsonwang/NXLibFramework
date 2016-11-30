//
//  NXScrollView.h
//  NXlib
//
//  Created by AK on 3/6/14.
//  Copyright (c) 2014 AK. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  Page方向
 */
typedef NS_ENUM(NSUInteger, NXScrollViewPageDirection) {
    /**
     *  水平
     */
    NXScrollViewPageDirectionHorizontal,
    /**
     *  垂直
     */
    NXScrollViewPageDirectionVertical,
};

@protocol NXScrollViewTouchDelegate;

@interface NXScrollView : UIScrollView

@property(nonatomic, weak) id<NXScrollViewTouchDelegate> touchDelegate;

@property(nonatomic, assign) BOOL endEditingWhenTouch;

@property(nonatomic, assign) NSInteger numberOfPages;

@property(nonatomic, assign) NXScrollViewPageDirection pageDirection;

- (NSInteger)currentPage;

- (BOOL)isFirstPage;
- (BOOL)isLastPage;

- (void)scrollToPreviousPage;
- (void)scrollToNextPage;
- (void)scrollToFirstPage;
- (void)scrollToLastPage;

@end

@protocol NXScrollViewTouchDelegate<NSObject>

@optional
- (void)scrollView:(NXScrollView *)scrollView touchEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)scrollView:(NXScrollView *)scrollView
  touchShouldBegin:(NSSet *)touches
         withEvent:(UIEvent *)event
     inContentView:(id)view;

@end
