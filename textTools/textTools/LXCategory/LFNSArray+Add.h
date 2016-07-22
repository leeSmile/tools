//
//  NSArray+LFAdd.h
//
//
//  Created by guoyaoyuan on 13-4-4.
//  Copyright (c) 2013 live Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Provide some some common method for `NSArray`.
 */
@interface NSArray (LFNSArrayAdditions)

/// 随机返回一个对象 (如果Array空，则返回nil)
- (id)lf_randomObject;

/// 和 `objectAtIndex:` 类似，但超出范围不会抛异常
- (id)lf_objectOrNilAtIndex:(NSUInteger)index;

/// 编码为 json 字符串。 如果出错则返回nil。 内容支持NSString/NSNumber/NSDictionary/NSArray
- (NSString *)lf_jsonStringEncoded;

/// 编码为 json 字符串(带格式)。 如果出错则返回nil。 内容支持NSString/NSNumber/NSDictionary/NSArray
- (NSString *)lf_jsonPrettyStringEncoded;

@end



@interface NSMutableArray (LFAdd)



@end
