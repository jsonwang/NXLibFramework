//
//  NXLabel.h
//  NXlib
//
//  Created by AK on 3/6/14.
//  Copyright (c) 2014 AK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NXLabel : UILabel

- (void)setText:(NSString *)text adjustWidth:(BOOL)adjustWidth;
- (void)setText:(NSString *)text adjustHeight:(BOOL)adjustHeight;

@end
