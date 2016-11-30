//
//  FreakyCreateUITool.h
//  Freaky
//
//  Created by 王成 on 14-8-3.
//  Copyright (c) 2014年 AK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NXCreateUITool : NSObject

+ (UILabel *)createLabelInitWithFrame:(CGRect)frame
                      backgroundColor:(UIColor *)backColor
                        textAlignment:(NSTextAlignment)alignment
                                 text:(NSString *)text
                            textColor:(UIColor *)textColor
                                 font:(UIFont *)font
                            superView:(UIView *)superView;

+ (UIImageView *)createImageViewWithPoint:(CGPoint)point fileName:(NSString *)fileName superView:(UIView *)superView;

+ (UIButton *)createButtonWithPoint:(CGPoint)point
                normalImageFileName:(NSString *)normalImageFileName
                  highlightFileName:(NSString *)highlightFileName
                          superView:(UIView *)superView;

+ (UIButton *)createButtonWithRect:(CGRect)rect superView:(UIView *)superView;

+ (UIButton *)createTextButtonWithPoint:(CGPoint)point title:(NSString *)titleStr superView:(UIView *)superView;
//纵向 image + text
+ (UIButton *)createTextAndImageButtonWithRect:(CGRect)rect
                                         image:(NSString *)imageName
                                          text:(NSString *)title
                                     superView:(UIView *)superView;
//横向 image + text
+ (UIButton *)createButtonWithImage:(NSString *)imageName
                               text:(NSString *)title
                               rect:(CGRect)rect
                          superView:(UIView *)superView;

+ (UIImageView *)createSeparatorLineWithPoint:(CGPoint)point superView:(UIView *)superView;

//垂直分割线
+ (UIImageView *)createVerticalLineWithPoint:(CGPoint)point height:(float)height superView:(UIView *)superView;

+ (UIBarButtonItem *)navigationItemWithNameString:(NSString *)name
                                           Target:(id)target
                                           action:(SEL)action
                                           isleft:(BOOL)isleft;

+ (UIBarButtonItem *)navigationItemBackImage:(UIImage *)naviImage
                                 highlighted:(UIImage *)hightLightedImage
                                      Target:(id)target
                                      action:(SEL)action
                                      isLeft:(BOOL)isleft;

+ (UILabel *)setNavigationItmeTitleView:(NSString *)title;

+ (UIView *)createTipViewWithStartY:(CGFloat)startY
                         buttonText:(NSString *)btntitle
                            tipText:(NSString *)tipTex
                          addTarget:(id)taget
                             action:(SEL)selector
                          superView:(UIView *)superView;

//音乐封面 自己截得圆
+ (UIImageView *)musicCoverImageViewWithFrame:(CGRect)frame innerWidth:(float)width superView:(UIView *)superView;

//换UISwitch颜色
+ (void)changeSwitchBtnColor:(UISwitch *)cellSwitch;

+ (UIImage *)scaleImage:(UIImage *)image size:(CGSize)newSize;

@end
