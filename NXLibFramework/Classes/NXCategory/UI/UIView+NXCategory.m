//
//  UIView+UIView_RoundedCorners.m
//  NXLib
//
//  Created by AK on 14-3-27.
//  Copyright (c) 2014年 AK. All rights reserved.
//

#import "UIView+NXCategory.h"

static NSString *NXViewStringTagKey = @"NXViewStringTagKey";

@implementation UIView (NXCategory)

- (float)x { return self.nx_x; }
- (void)setX:(float)newX { self.nx_x = newX; }
- (float)y { return self.nx_y; }
- (void)setY:(float)newY { self.nx_y = newY; }
- (float)nx_x { return self.frame.origin.x; }
- (void)setNx_x:(float)newX
{
    CGRect frame = self.frame;
    frame.origin.x = newX;
    self.frame = frame;
}

- (float)nx_y { return self.frame.origin.y; }
- (void)setNx_y:(float)newY
{
    CGRect frame = self.frame;
    frame.origin.y = newY;
    self.frame = frame;
}
- (void)setNx_width:(float)nx_width
{
    CGRect frame = self.frame;
    frame.size.width = nx_width;
    self.frame = frame;
}

- (float)nx_width { return self.frame.size.width; }
- (void)setNx_height:(float)nx_height
{
    CGRect frame = self.frame;
    frame.size.height = nx_height;
    self.frame = frame;
}

- (float)nx_height { return self.frame.size.height; }
#pragma mark - Frame
- (CGPoint)nx_middle { return CGPointMake(CGRectGetWidth(self.frame) / 2.0, CGRectGetHeight(self.frame) / 2.0); }
- (CGSize)nx_orientationSize
{
    BOOL swap = !NXiOS8OrLater() && [NXSystemInfo isLandscape];
    return swap ? NXSizeSWAP(self.size) : self.size;
}

- (CGFloat)nx_orientationWidth { return self.nx_orientationSize.width; }
- (CGFloat)nx_orientationHeight { return self.nx_orientationSize.height; }
- (CGPoint)nx_orientationMiddle
{
    return CGPointMake(self.nx_orientationSize.width / 2.0, self.nx_orientationSize.height / 2.0);
}

- (void)nx_setStringTag:(NSString *)tag { [self setTag:[tag hash]]; }
- (UIView *)nx_getViewWithStringTag:(NSString *)tag { return [self viewWithTag:[tag hash]]; }
#pragma mark - Border radius

- (void)nx_rounded:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)nx_rounded:(CGFloat)cornerRadius width:(CGFloat)borderWidth color:(UIColor *)borderColor
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = [borderColor CGColor];
    self.layer.masksToBounds = YES;
}

- (void)nx_border:(CGFloat)borderWidth color:(UIColor *)borderColor
{
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = [borderColor CGColor];
    self.layer.masksToBounds = YES;
}

- (void)nx_setRoundedCorners:(UIRectCorner)corners radius:(CGSize)size
{
    UIBezierPath *maskPath =
        [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:size];
    CAShapeLayer *maskLayer = [CAShapeLayer new];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

#pragma mark - Animation

+ (void)nx_animateFollowKeyboard:(NSDictionary *)userInfo
                      animations:(void (^)(NSDictionary *userInfo))animations
                      completion:(void (^)(BOOL finished))completion
{
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;

    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];

    UIViewAnimationOptions options = ((animationCurve << 16) | UIViewAnimationOptionBeginFromCurrentState);

    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:options
                     animations:^{
                         if (animations)
                         {
                             animations(userInfo);
                         }
                     }
                     completion:completion];
}

#pragma mark - Public Method

- (UIView *)nx_firstResponder
{
    if ([self isFirstResponder])
    {
        return self;
    }
    UIView *firstResponder = nil;
    NSArray *subviews = self.subviews;
    for (UIView *subview in subviews)
    {
        firstResponder = [subview nx_firstResponder];
        if (firstResponder)
        {
            return firstResponder;
        }
    }
    return nil;
}

@end
