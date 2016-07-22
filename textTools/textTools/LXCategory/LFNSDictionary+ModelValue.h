//
//  NSDictionary+NSDictionaryExt.h
//  LaiFeng
//
//  Created by xinliu on 14-5-20.
//  Copyright (c) 2014年 live Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSDictionary (LFModelValueAdditions)

/*
 返回指定key的timeInterval值
 没有指定key的值，返回默认值
 */
-(NSTimeInterval)lf_timeIntervalForKey:(NSString *)key withDefault:(NSTimeInterval)defVal;

/// 源字符串是 timestamp 毫秒数
- (NSDate *)lf_timestampDataForKey:(NSString *)key withDefault:(NSDate *)defVal;

- (NSString*)lf_queryString;


- (id)lf_objectForKey:(NSString*)key class:(Class)aClass;




#pragma mark - Dictionary Value Getter
///=============================================================================
/// @name Dictionary Value Getter
///=============================================================================

- (BOOL)lf_boolForKey:(NSString *)key withDefault:(BOOL)def;
- (char)lf_charForKey:(NSString *)key withDefault:(char)def;
- (unsigned char)lf_unsignedCharForKey:(NSString *)key withDefault:(unsigned char)def;
- (short)lf_shortForKey:(NSString *)key withDefault:(short)def;
- (unsigned short)lf_unsignedShortForKey:(NSString *)key withDefault:(unsigned short)def;
- (int)lf_intForKey:(NSString *)key withDefault:(int)def;
- (unsigned int)lf_unsignedIntForKey:(NSString *)key withDefault:(unsigned int)def;
- (long)lf_longForKey:(NSString *)key withDefault:(long)def;
- (unsigned long)lf_unsignedLongForKey:(NSString *)key withDefault:(unsigned long)def;
- (long long)lf_longLongForKey:(NSString *)key withDefault:(long long)def;
- (unsigned long long)lf_unsignedLongLongForKey:(NSString *)key withDefault:(unsigned long long)def;
- (float)lf_floatForKey:(NSString *)key withDefault:(float)def;
- (double)lf_doubleForKey:(NSString *)key withDefault:(double)def;
- (NSInteger)lf_integerForKey:(NSString *)key withDefault:(NSInteger)def;
- (NSUInteger)lf_unsignedIntegerForKey:(NSString *)key withDefault:(NSUInteger)def;
- (NSNumber *)lf_numberForKey:(NSString *)key withDefault:(NSNumber *)def;
- (NSString *)lf_stringForKey:(NSString *)key withDefault:(NSString *)def;

- (BOOL)lf_boolForKey:(NSString *)key;
- (char)lf_charForKey:(NSString *)key;
- (unsigned char)lf_unsignedCharForKey:(NSString *)key;
- (short)lf_shortForKey:(NSString *)key;
- (unsigned short)lf_unsignedShortForKey:(NSString *)key;
- (int)lf_intForKey:(NSString *)key;
- (unsigned int)lf_unsignedIntForKey:(NSString *)key;
- (long)lf_longForKey:(NSString *)key;
- (unsigned long)lf_unsignedLongForKey:(NSString *)key;
- (long long)lf_longLongForKey:(NSString *)key;
- (unsigned long long)lf_unsignedLongLongForKey:(NSString *)key;
- (float)lf_floatForKey:(NSString *)key;
- (double)lf_doubleForKey:(NSString *)key;
- (NSInteger)lf_integerForKey:(NSString *)key;
- (NSUInteger)lf_unsignedIntegerForKey:(NSString *)key;
- (NSNumber *)lf_numberForKey:(NSString *)key;
- (NSString *)lf_stringForKey:(NSString *)key;

@end
