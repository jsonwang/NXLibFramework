//
//  UIImage+UIImage_NXCategory.m
//  AKImovie
//
//  Created by AK on 16/2/21.
//  Copyright © 2016年 ak. All rights reserved.
//

#import "UIImage+NXCategory.h"

#import <CoreText/CoreText.h>

@implementation UIImage (NXCategory)

+ (UIImage *)nx_blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur
{
    CIImage *inputImage = [CIImage imageWithCGImage:image.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"
                                  keysAndValues:kCIInputImageKey, inputImage, @"inputRadius", @(blur), nil];

    CIImage *outputImage = filter.outputImage;
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef outImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    return [UIImage imageWithCGImage:outImage];
}

@end
