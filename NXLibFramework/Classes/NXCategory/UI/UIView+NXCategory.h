//
//  UIView+UIView_RoundedCorners.h
//  NXLib
//
//  Created by AK on 14-3-27.
//  Copyright (c) 2014年 AK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (NXCategory)

#pragma mark - Deprecated
/**
 * NS_DEPRECATED 兼容旧版本,不建议使用.以后使用 nx_x 或 left_sd
 */
@property float x __deprecated_msg("兼容旧版本,不建议使用.以后使用 `nx_x` 或 `left_sd`");

/**
 *  NS_DEPRECATED 兼容旧版本,不建议使用.以后使用 nx_y 或 top_sd
 */
@property float y __deprecated_msg("兼容旧版本,不建议使用.以后使用 `nx_y` 或 `top_sd`");

@property float nx_x;
@property float nx_y;
@property float nx_width;
@property float nx_height;

@property(nonatomic, readonly) CGPoint nx_middle;

@property(nonatomic, readonly) CGSize nx_orientationSize;
@property(nonatomic, readonly) CGFloat nx_orientationWidth;
@property(nonatomic, readonly) CGFloat nx_orientationHeight;
@property(nonatomic, readonly) CGPoint nx_orientationMiddle;

/**
 *  设置view 的string tag
 *
 *  @param tag
 */
- (void)nx_setStringTag:(NSString *)tag;

/**
 *  根据tag 取view
 *
 *  @param tag
 *
 *  @return view
 */
- (UIView *)nx_getViewWithStringTag:(NSString *)tag;

#pragma mark - Border radius

/**
 *  @brief 设置圆角
 *
 *  @param cornerRadius 圆角半径
 */
- (void)nx_rounded:(CGFloat)cornerRadius;

/**
 *  @brief 设置圆角和边框
 *
 *  @param cornerRadius 圆角半径
 *  @param borderWidth  边框宽度
 *  @param borderColor  边框颜色
 */
- (void)nx_rounded:(CGFloat)cornerRadius width:(CGFloat)borderWidth color:(UIColor *)borderColor;

/**
 *  @brief 设置边框
 *
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 */
- (void)nx_border:(CGFloat)borderWidth color:(UIColor *)borderColor;

/**
 *  控制性圆角（如左上、右下等)
 *
 *  @param corners 方位可多值
 *  @param size    大小
 */
- (void)nx_setRoundedCorners:(UIRectCorner)corners radius:(CGSize)size;

#pragma mark - Animation

+ (void)nx_animateFollowKeyboard:(NSDictionary *)userInfo
                      animations:(void (^)(NSDictionary *userInfo))animations
                      completion:(void (^)(BOOL finished))completion;

#pragma mark - Public Method

- (UIView *)nx_firstResponder;

@end
