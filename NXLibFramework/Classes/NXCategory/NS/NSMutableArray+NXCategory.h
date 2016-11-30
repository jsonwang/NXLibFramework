//
//  NSMutableArray+Moving.h
//  NXLib
//
//  Created by AK on 14-3-28.
//  Copyright (c) 2014年 AK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (NXCategory)

/**
 Moves the object at the specified indexes to the new location.

 @param indexes The indexes of the objects to move.
 @param idx The index in the mutable array at which to insert the objects.
 */
- (void)nx_moveObjectsAtIndexes:(NSIndexSet *)indexes toIndex:(NSUInteger)idx;

@end
