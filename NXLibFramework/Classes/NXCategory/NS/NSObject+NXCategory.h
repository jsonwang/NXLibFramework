//
//  NSObject+NXCategory.h
//  YOYO
//
//  Created by AK on 5/12/14.
//
//

#import <Foundation/Foundation.h>

#define FULLDESCRIPTIONCATEGORY

@interface NSObject (NXCategory)
{
}
+ (BOOL)nx_swizzleMethod:(SEL)origSel withMethod:(SEL)altSel;

+ (BOOL)nx_swizzleClassMethod:(SEL)origSel withClassMethod:(SEL)altSel;
/**
 *  打印本类的所有变量(成员变量+属性变量)和所有层级父类的属性变量及其对应的值
 *
 *  @return 拼接 string
 */
- (NSString *)nx_fullDescription;

//判断对象为空
- (BOOL)nx_isNull:(id)object;

@end
