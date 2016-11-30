//
//  NXPageControl.m
//  ZhongTouBang
//
//  Created by AK on 7/16/14.
//  Copyright (c) 2014 AK. All rights reserved.
//

#import "NXPageControl.h"

@interface NXPageControl ()

@property(nonatomic, assign) BOOL firstPage;
@property(nonatomic, assign) BOOL lastPage;

@end

@implementation NXPageControl

- (BOOL)firstPage { return self.currentPage == 0; }

- (BOOL)lastPage { return self.currentPage == self.numberOfPages - 1; }

@end
