//
//  NXToolbar.h
//  NXlib
//
//  Created by AK on 9/23/14.
//  Copyright (c) 2014 AK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, NXToolbarActionStyle)
{
    NXToolbarActionStyleNone,
    NXToolbarActionStyleDoneAndCancel,
};

@protocol NXToolbarActionDelegate;

@interface NXToolbar : UIToolbar

@property(nonatomic, weak) id<NXToolbarActionDelegate> actionDelegate;

@property(nonatomic, assign) NXToolbarActionStyle actionStyle;

- (instancetype)initWithFrame:(CGRect)frame actionStyle:(NXToolbarActionStyle)actionStyle;

@end

@protocol NXToolbarActionDelegate<NSObject>

- (void)toolbarDidDone:(NXToolbar *)toolbar;
- (void)toolbarDidCancel:(NXToolbar *)toolbar;

@end
