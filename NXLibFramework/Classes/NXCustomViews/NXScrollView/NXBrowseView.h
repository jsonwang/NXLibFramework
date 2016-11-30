//
//  NXBrowseView.h
//  NXlib
//
//  Created by AK on 8/5/14.
//  Copyright (c) 2014 AK. All rights reserved.
//

#import "NXScrollView.h"
#import "NXBrowseViewPage.h"

@class NXBrowseView;

@protocol NXBrowseViewDataSource;
@protocol NXBrowseViewDelegate;

@interface NXBrowseView : NXScrollView

@property(nonatomic, weak) id<NXBrowseViewDataSource> browseDataSource;
@property(nonatomic, weak) id<NXBrowseViewDelegate> browseDelegate;

- (id)dequeueReusablePageWithIdentifier:(NSString *)identifier;

- (void)reloadData;

- (NSInteger)indexForPageAtPoint:(CGPoint)point;
- (NSInteger)indexForPage:(NXBrowseViewPage *)page;
- (NXBrowseViewPage *)pageForIndex:(NSInteger)index;

- (void)startPageing;
- (void)stopPageing;

@end

@protocol NXBrowseViewDataSource<NSObject>

@required
- (NSInteger)numberOfPagesInBrowseView:(NXBrowseView *)browseView;
- (NXBrowseViewPage *)browseView:(NXBrowseView *)browseView pageAtIndex:(NSInteger)index;

@end

@protocol NXBrowseViewDelegate<NSObject>

@optional
- (void)browseView:(NXBrowseView *)browseView willSelectPageAtIndex:(NSInteger)index;
- (void)browseView:(NXBrowseView *)browseView didSelectPageAtIndex:(NSInteger)index;
- (void)browseViewDidScroll:(NXBrowseView *)browseView;

@end
