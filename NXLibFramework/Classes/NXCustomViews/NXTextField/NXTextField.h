//
//  NXTextField.h
//  NXlib
//
//  Created by AK on 3/6/14.
//  Copyright (c) 2014 AK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NXTextField : UITextField

@property(nonatomic, strong) UIImage *leftImage;
@property(nonatomic, copy) NSString *leftText;

- (void)setLeftText:(NSString *)leftText forFont:(UIFont *)font;

@end
