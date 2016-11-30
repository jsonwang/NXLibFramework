//
//  UIBarButtonItem+NXAddition.h
//  NXlib
//
//  Created by AK on 9/23/14.
//  Copyright (c) 2014 AK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (NXAddition)

- (instancetype)initWithTarget:(id)target action:(SEL)action;
- (instancetype)initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem;
- (instancetype)initWithFixedSpaceWidth:(CGFloat)spaceWidth;
+ (instancetype)nx_flexibleSpaceSystemItem;

@end
