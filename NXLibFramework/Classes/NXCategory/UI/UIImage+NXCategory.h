//
//  UIImage+UIImage_NXCategory.h
//  AKImovie
//
//  Created by AK on 16/2/21.
//  Copyright © 2016年 ak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (NXCategory)

+ (UIImage *)nx_blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;

@end
