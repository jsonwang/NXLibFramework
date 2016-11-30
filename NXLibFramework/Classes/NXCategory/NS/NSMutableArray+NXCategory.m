//
//  NSMutableArray+Moving.m
//  NXLib
//
//  Created by AK on 14-3-28.
//  Copyright (c) 2014年 AK. All rights reserved.
//

#import "NSMutableArray+NXCategory.h"

@implementation NSMutableArray (NXCategory)

// @see: http://www.cocoabuilder.com/archive/cocoa/189484-nsarray-move-items-at-indexes.html

- (void)nx_moveObjectsAtIndexes:(NSIndexSet *)indexes toIndex:(NSUInteger)idx
{
    NSArray *objectsToMove = [self objectsAtIndexes:indexes];

    // If any of the removed objects come before the index, we want to decrement the index appropriately
    idx -= [indexes countOfIndexesInRange:(NSRange){0, idx}];

    [self removeObjectsAtIndexes:indexes];
    [self replaceObjectsInRange:(NSRange) { idx, 0 } withObjectsFromArray:objectsToMove];
}

@end
