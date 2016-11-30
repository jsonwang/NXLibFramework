//
//  NSDictionary+Error.h
//  NXLib
//
//  Created by AK on 14-3-28.
//  Copyright (c) 2014年 AK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NXCategory)

/**
 *  判断不为空
 *
 *  @return YES 为不为空
 */
- (BOOL)nx_isNotEmpty;

- (NSArray *)nx_arrayForKey:(id)aKey;
- (NSDictionary *)nx_dictionaryForKey:(id)aKey;

- (NSString *)nx_stringForKey:(id)aKey;
- (NSInteger)nx_integerForKey:(id)aKey;
- (int)nx_intForKey:(id)aKey;
- (float)nx_floatForKey:(id)aKey;
- (double)nx_doubleForKey:(id)aKey;
- (BOOL)nx_boolForKey:(id)aKey;

/**
 *  拼接dic所有KEY 的值
 *
 *  @return 拼接值 e.g.

    NSDictionary *dic =@{@"a":@"1",@"b":@"2",@"c":@"3"};
    NSLog(@"dic:%@",[dic nx_paramString]); returndic:a=1&b=2&c=3

 */
- (NSString *)nx_paramString;
@end
