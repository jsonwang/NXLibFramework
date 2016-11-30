//
//  NXActionSheet.h
//  NXlib
//
//  Created by AK on 14/12/8.
//  Copyright (c) 2014年 AK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^NXActionSheetClickedHandler)(UIActionSheet *actionSheet, NSInteger buttonIndex);
typedef void (^NXActionSheetCancelHandler)(UIActionSheet *actionSheet);
typedef void (^NXActionSheetWillPresentHandler)(UIActionSheet *actionSheet);
typedef void (^NXActionSheetDidPresentHandler)(UIActionSheet *actionSheet);
typedef void (^NXActionSheetWillDismissHandler)(UIActionSheet *actionSheet, NSInteger buttonIndex);
typedef void (^NXActionSheetDidDismissHandler)(UIActionSheet *actionSheet, NSInteger buttonIndex);

@interface NXActionSheet : UIActionSheet

- (void)setClickedHandler:(NXActionSheetClickedHandler)clickedHandler;
- (void)setCancelHandler:(NXActionSheetCancelHandler)cancelHandler;
- (void)setWillPresentHandler:(NXActionSheetWillPresentHandler)willPresentHandler;
- (void)setDidPresentHandler:(NXActionSheetDidPresentHandler)didPresentHandler;
- (void)setWillDismissHandler:(NXActionSheetWillDismissHandler)willDismissHandler;
- (void)setDidDismissHandler:(NXActionSheetDidDismissHandler)didDismissHandler;

@end
