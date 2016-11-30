//
//  UIColor+NXAddition.h
//  NXlib
//
//  Created by AK on 3/5/14.
//  Copyright (c) 2014 AK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (NXAddition)

+ (UIColor *)nx_colorWithWholeRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

+ (UIColor *)nx_colorWithWholeRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

+ (UIColor *)nx_colorWithHex:(NSInteger)hexColor alpha:(CGFloat)alpha;

+ (UIColor *)nx_colorWithHex:(NSInteger)hexColor;

- (NSArray *)nx_RGBComponents;

@end
