//
//  NXCreateUITool.m
//  NX
//
//  Created by 王成 on 14-8-3.
//  Copyright (c) 2014年 NX-corp.com. All rights reserved.
//

#import "NXCreateUITool.h"

#import "UIControl+NXCategory.h"

/////////////////////////////////////////////////////////

#define BASE_TEXT_COLOR NX_UIColorFromRGB(0xffffff)

#define NX_FONT_18 18

#define NX_FONT_14 14

/////////////////////////////////////////////////////////

/***********************视觉规范宏定义***********************/

// 通用色彩规范

#define NX_COLOR_HL_GREEN NX_UIColorFromRGB(0x12ffc0)  // 银光绿

#define NX_COLOR_TEXT_GRAY NX_UIColorFromRGB(0x929292)  // 文字灰色

#define NX_COLOR_WHITE NX_UIColorFromRGB(0xffffff)  // 白色

#define NX_COLOR_RED NX_UIColorFromRGB(0xf9706d)  // 红色

#define NX_COLOR_BACK_BLACK NX_UIColorFromRGB(0x151515)  // 背景黑色

#define NX_COLOR_BACK_GRAY NX_UIColorFromRGB(0x1b1b1b)  // 浅灰背景色

#define NX_COLOR_LINE_GRAY NX_UIColorFromRGB(0xdcdcdc)  // 分割线

/************************************************************/

@implementation NXCreateUITool
// uilabel
+ (UILabel *)createLabelInitWithFrame:(CGRect)frame
                      backgroundColor:(UIColor *)backColor
                        textAlignment:(NSTextAlignment)alignment
                                 text:(NSString *)text
                            textColor:(UIColor *)textColor
                                 font:(UIFont *)font
                            superView:(UIView *)superView
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:frame];
    titleLabel.backgroundColor = backColor;
    titleLabel.textAlignment = alignment;
    titleLabel.text = text;
    titleLabel.textColor = textColor;
    titleLabel.font = font;
    if (superView)
    {
        [superView addSubview:titleLabel];
    }
    return titleLabel;
}

// uiimage
+ (UIImageView *)createImageViewWithPoint:(CGPoint)point fileName:(NSString *)fileName superView:(UIView *)superView
{
    UIImage *image = [UIImage imageNamed:fileName];

    UIImageView *imageView =
        [[UIImageView alloc] initWithFrame:CGRectMake(point.x, point.y, image.size.width, image.size.height)];
    [imageView setImage:image];
    if (superView)
    {
        [superView addSubview:imageView];
    }

    return imageView;
}

+ (UIButton *)createButtonWithPoint:(CGPoint)point
                normalImageFileName:(NSString *)normalImageFileName
                  highlightFileName:(NSString *)highlightFileName
                          superView:(UIView *)superView
{
    UIImage *normalImage = [UIImage imageNamed:normalImageFileName];
    UIButton *btn =
        [[UIButton alloc] initWithFrame:CGRectMake(point.x, point.y, normalImage.size.width, normalImage.size.height)];
    //    btn.uxy_acceptEventInterval=0.2;

    btn.exclusiveTouch = YES;
    [btn setTitleColor:BASE_TEXT_COLOR forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    btn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
    if (highlightFileName && highlightFileName.length > 0)
    {
        [btn setBackgroundImage:[UIImage imageNamed:highlightFileName] forState:UIControlStateHighlighted];
    }

    if (superView)
    {
        [superView addSubview:btn];
    }

    return btn;
}
+ (UIButton *)createTextButtonWithPoint:(CGPoint)point title:(NSString *)titleStr superView:(UIView *)superView
{
    UIButton *_backBtn = [[UIButton alloc] initWithFrame:CGRectMake(point.x, point.y, 64, 44)];
    //    _backBtn.uxy_acceptEventInterval=0.2;

    _backBtn.exclusiveTouch = YES;
    _backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    _backBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _backBtn.backgroundColor = [UIColor clearColor];

    _backBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_backBtn setTitle:titleStr forState:UIControlStateNormal];
    _backBtn.titleLabel.font = [UIFont systemFontOfSize:NX_FONT_18];
    [_backBtn setTitleColor:BASE_TEXT_COLOR forState:UIControlStateNormal];
    [superView addSubview:_backBtn];
    return _backBtn;
}
+ (UIButton *)createButtonWithRect:(CGRect)rect superView:(UIView *)superView
{
    UIButton *btn =
        [[UIButton alloc] initWithFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)];
    //    btn.uxy_acceptEventInterval=0.2;
    btn.backgroundColor = [UIColor clearColor];
    btn.exclusiveTouch = YES;
    [btn setTitleColor:BASE_TEXT_COLOR forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    btn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

    if (superView)
    {
        [superView addSubview:btn];
    }

    return btn;
}
+ (UIButton *)createTextAndImageButtonWithRect:(CGRect)rect
                                         image:(NSString *)imageName
                                          text:(NSString *)title
                                     superView:(UIView *)superView
{
    UIButton *btn = [[UIButton alloc] initWithFrame:rect];
    //    btn.uxy_acceptEventInterval=0.2;
    btn.exclusiveTouch = YES;
    [btn setBackgroundColor:[UIColor clearColor]];

    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    btn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

    UIImage *image = [UIImage imageNamed:imageName];
    //    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateHighlighted];

    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:NX_UIColorFromRGB(0x868686) forState:UIControlStateNormal];

    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];

    btn.titleLabel.textAlignment = NSTextAlignmentLeft;
    btn.titleLabel.font = [UIFont systemFontOfSize:12];

    btn.layer.borderWidth = 0.5;
    btn.layer.borderColor = NX_UIColorFromRGB(0xe6e6e6).CGColor;
    [superView addSubview:btn];

    return btn;
}

+ (UIButton *)createButtonWithImage:(NSString *)imageName
                               text:(NSString *)title
                               rect:(CGRect)rect
                          superView:(UIView *)superView
{
    UIButton *btn =
        [[UIButton alloc] initWithFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)];
    btn.backgroundColor = [UIColor clearColor];
    btn.exclusiveTouch = YES;
    //    btn.uxy_acceptEventInterval=0.2;

    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    btn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

    UIImage *image = [UIImage imageNamed:imageName];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];

    [btn setTitleColor:NX_UIColorFromRGB(0x696969) forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    btn.titleLabel.textAlignment = NSTextAlignmentLeft;
    btn.titleLabel.font = [UIFont systemFontOfSize:14];

    [superView addSubview:btn];

    return btn;
}
+ (UIImageView *)createSeparatorLineWithPoint:(CGPoint)point superView:(UIView *)superView
{
    UIImageView *separatorLineView =
        [[UIImageView alloc] initWithFrame:CGRectMake(point.x * (SCREEN_WIDTH / 320.), point.y,
                                                      SCREEN_WIDTH - 2 * point.x * (SCREEN_WIDTH / 320.), 0.5)];
    separatorLineView.backgroundColor = NX_COLOR_LINE_GRAY;

    [superView addSubview:separatorLineView];

    return separatorLineView;
}
+ (UIImageView *)createVerticalLineWithPoint:(CGPoint)point height:(float)height superView:(UIView *)superView
{
    UIImageView *separatorLineView = [[UIImageView alloc] initWithFrame:CGRectMake(point.x, point.y, 1 / 2., height)];

    separatorLineView.backgroundColor = NX_COLOR_LINE_GRAY;
    [superView addSubview:separatorLineView];

    return separatorLineView;
}
+ (UIBarButtonItem *)navigationItemWithNameString:(NSString *)name
                                           Target:(id)target
                                           action:(SEL)action
                                           isleft:(BOOL)isleft
{
    UIButton *naviBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, (name.length > 2) ? 64 : 44, 44)];
    naviBtn.exclusiveTouch = YES;
    [naviBtn setTitle:name forState:UIControlStateNormal];
    if (name.length == 4)
    {
        [naviBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    else
    {
        [naviBtn setTitleColor:NX_UIColorFromRGB(0xf55955) forState:UIControlStateNormal];
    }
    naviBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [naviBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

    naviBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [naviBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];

    //设置字的位置
    if (isleft)
    {
        naviBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    else
    {
        naviBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    }

    UIBarButtonItem *naviBtnItem = [[UIBarButtonItem alloc] initWithCustomView:naviBtn];
    return naviBtnItem;
}

+ (UIBarButtonItem *)navigationItemBackImage:(UIImage *)naviImage
                                 highlighted:(UIImage *)hightLightedImage
                                      Target:(id)target
                                      action:(SEL)action
                                      isLeft:(BOOL)isleft
{
    UIButton *naviBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, naviImage.size.width, naviImage.size.height)];
    //    naviBtn.uxy_acceptEventInterval=0.2;

    naviBtn.exclusiveTouch = YES;
    if (naviImage)
    {
        [naviBtn setImage:naviImage forState:UIControlStateNormal];
    }
    if (hightLightedImage)
    {
        [naviBtn setImage:hightLightedImage forState:UIControlStateHighlighted];
    }

    if (isleft)
    {
        naviBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        naviBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    else
    {
        naviBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        naviBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    if (action)
    {
        [naviBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    if (!naviImage || !hightLightedImage)
    {
        NSLog(@"navigationImage is nil");
    }
    UIBarButtonItem *naviBtnItem = [[UIBarButtonItem alloc] initWithCustomView:naviBtn];
    return naviBtnItem;
}

+ (UILabel *)setNavigationItmeTitleView:(NSString *)title
{
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];

    [titleLable setFont:[UIFont systemFontOfSize:18]];
    titleLable.center = CGPointMake(SCREEN_WIDTH / 2., 22);
    titleLable.textColor = NX_UIColorFromRGB(0x797979);
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.text = title;

    return titleLable;
}

+ (UIView *)createTipViewWithStartY:(CGFloat)startY
                         buttonText:(NSString *)btntitle
                            tipText:(NSString *)tipTex
                          addTarget:(id)taget
                             action:(SEL)selector
                          superView:(UIView *)superView
{
    UIView *tipView = [[UIView alloc] initWithFrame:CGRectMake(0, startY, SCREEN_WIDTH, 90)];
    tipView.backgroundColor = [UIColor clearColor];
    [superView addSubview:tipView];
    float labelY = 36 / 2.;
    if (btntitle.length > 0)
    {
        UIButton *button = [NXCreateUITool createTextButtonWithPoint:CGPointZero title:btntitle superView:tipView];

        //        button.uxy_acceptEventInterval=0.2;

        [button addTarget:taget action:selector forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:NX_COLOR_HL_GREEN forState:UIControlStateNormal];
        button.frame = CGRectMake((SCREEN_WIDTH - 250) / 2., 0, 250, 44);

        [button setBackgroundImage:[UIImage imageNamed:@"bg_pressed8.png"] forState:UIControlStateHighlighted];
        button.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.2].CGColor;
        button.layer.borderWidth = 1;
        labelY = labelY - 44;
    }

    if (tipTex.length > 0)
    {
        [NXCreateUITool createLabelInitWithFrame:CGRectMake(0, labelY, SCREEN_WIDTH, 15)
                                 backgroundColor:[UIColor clearColor]
                                   textAlignment:NSTextAlignmentCenter
                                            text:tipTex
                                       textColor:NX_COLOR_TEXT_GRAY
                                            font:[UIFont systemFontOfSize:NX_FONT_14]
                                       superView:tipView];
    }

    return tipView;
}

+ (UIImageView *)musicCoverImageViewWithFrame:(CGRect)frame innerWidth:(float)width superView:(UIView *)superView
{
    UIImageView *musicImgV = [[UIImageView alloc] initWithFrame:frame];
    //切圆
    musicImgV.contentMode = UIViewContentModeScaleAspectFill;
    musicImgV.layer.cornerRadius = CGRectGetHeight(frame) / 2.;
    musicImgV.layer.masksToBounds = YES;
    [superView addSubview:musicImgV];

    //中间掏空
    UIView *inView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
    inView.center = musicImgV.center;
    inView.backgroundColor = [UIColor whiteColor];
    inView.layer.cornerRadius = width / 2.;
    inView.layer.masksToBounds = YES;
    [superView addSubview:inView];

    return musicImgV;
}

//换UISwitch颜色
+ (void)changeSwitchBtnColor:(UISwitch *)cellSwitch
{
    if (cellSwitch.on)
    {
        //底色
        [cellSwitch setTintColor:NX_UIColorFromRGB(0x5c5c5c)];
        //快选中时候的底色
        [cellSwitch setOnTintColor:NX_UIColorFromRGB(0x575757)];
        //按钮颜色
        [cellSwitch setThumbTintColor:NX_COLOR_HL_GREEN];
    }
    else
    {
        [cellSwitch setTintColor:NX_UIColorFromRGB(0x575757)];
        [cellSwitch setOnTintColor:NX_UIColorFromRGB(0x575757)];

        [cellSwitch setThumbTintColor:[UIColor whiteColor]];
    }
}

+ (UIImage *)scaleImage:(UIImage *)image size:(CGSize)newSize
{
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
