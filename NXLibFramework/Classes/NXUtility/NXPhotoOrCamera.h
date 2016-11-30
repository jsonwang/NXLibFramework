//
//  NXPhotoOrCamera.h
//
//  Created by 王成 on 14-6-22.
//
//

/**
 *  本类 功能 从相册或 相机里整出来一个相片
 *  eg. new the classes you can call all or sharedInstancd new object.
 */

/* 注意在使用本类的时候, 类 里要 调用 didReceiveMemoryWarning。
 - (void)didReceiveMemoryWarning
 {
 NSLog(@"didReceiveMemoryWarning");
 [super didReceiveMemoryWarning];
 
 [[NSURLCache sharedURLCache] removeAllCachedResponses];
 
 }
 
 */

#import <Foundation/Foundation.h>

@class NXPhotoOrCamera;
@protocol NXPhotoOrCameraDelegate<NSObject>

- (void)selectFinishedWithImage:(UIImage *)image photoOrCamera:(NXPhotoOrCamera *)photoOrCamera;

@end

@interface NXPhotoOrCamera : NSObject<UIActionSheetDelegate>

@property(nonatomic, assign) BOOL allowEdit;

@property(nonatomic, assign) id<NXPhotoOrCameraDelegate> delegate;

+ (NXPhotoOrCamera *)sharedInstance;

- (void)showActionSheetWithController:(UIViewController *)controller;

- (void)showImagePickerWithAnimation:(BOOL)hasAnimation sourceType:(UIImagePickerControllerSourceType)type;

@end
