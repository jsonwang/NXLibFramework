//
//  NSUserDefaults+NXCategory.h
//  NXLib
//
//  Created by AK on 14-3-27.
//  Copyright (c) 2014年 AK. All rights reserved.
//

#import <Foundation/Foundation.h>

// Macros standard
#define NXUserDefaults [NSUserDefaults standardUserDefaults]

@interface NSUserDefaults (NXCategory)<NSFastEnumeration>
// Fast Additions
- (void)nx_setObjects:(NSArray *)objects forKeys:(NSArray *)keys;
- (void)nx_addObjectsAndKeysFromDictionary:(NSDictionary *)keyValuePairs;
- (void)nx_addObjectsAndKeys:(id)firstObject, ... NS_REQUIRES_NIL_TERMINATION;

// Getting User Defaults with Fallback Value
- (id)nx_objectForKey:(NSString *)key or:(id)fallback;
- (NSString *)nx_stringForKey:(NSString *)key or:(NSString *)fallback;
- (NSArray *)nx_arrayForKey:(NSString *)key or:(NSArray *)fallback;
- (NSDictionary *)nx_dictionaryForKey:(NSString *)key or:(NSDictionary *)fallback;
- (NSData *)nx_dataForKey:(NSString *)key or:(NSData *)fallback;
- (NSInteger)nx_integerForKey:(NSString *)key or:(NSInteger)fallback;
- (CGFloat)nx_floatForKey:(NSString *)key or:(CGFloat)fallback;
- (BOOL)nx_boolForKey:(NSString *)key or:(BOOL)fallback;

/**
 *  判断某个值是否存在
 *
 *  @param key MK
 *
 *  @return YES OR NO
 */
- (BOOL)nx_hasValueForKey:(NSString *)key;

// 保存值 op
- (void)nx_saveObject:(id)value forKey:(NSString *)key;
- (void)nx_saveInteger:(NSInteger)value forKey:(NSString *)key;
- (void)nx_saveFloat:(CGFloat)value forKey:(NSString *)key;
- (void)nx_saveBool:(BOOL)value forKey:(NSString *)key;

// 重置值 op
- (void)nx_resetAllValues;
- (void)nx_resetValuesForKeys:(NSArray *)keys;
- (void)nx_removeAllValues;
- (void)nx_removeValuesForKeys:(NSArray *)keys;

// Storing Values
- (NSString *)nx_storeObject:(id)value;
- (NSString *)nx_storeInteger:(NSInteger)value;
- (NSString *)nx_storeFloat:(CGFloat)value;
- (NSString *)nx_storeBool:(BOOL)value;

// Synchronizing User Defaults
- (void)nx_startSyncingWithiCloud;
- (void)nx_stopSyncingWithiCloud;

@end
