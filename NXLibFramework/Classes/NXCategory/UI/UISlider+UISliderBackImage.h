//
//  UISlider+UISlider_backImage.h
//  NXLib
//
//  Created by AK on 14-3-17.
//  Copyright (c) 2014年 AK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISlider (UISlider_backImage)

- (void)nx_setTrackImageAndThumbImage:(UIImage *)thumbImage
                 minimumTrackImage:(UIImage *)minimumTrackImage
                 maximumTrackImage:(UIImage *)maximumTrackImage;

@end
