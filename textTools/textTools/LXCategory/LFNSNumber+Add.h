//
//  NSNumber+LFAdd.h
//
//
//  Created by guoyaoyuan on 13-8-24.
//  Copyright (c) 2013 live Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Provide a method to parse `NSString` for `NSNumber`.
 */
@interface NSNumber (LFAdd)

/**
 把字符串解析为NSNumber。(如解析失败则返回nil)
 
 支持各种格式，例如 @"12", @"12.345", @" -0xFF", @" .23e99 "
 不区分大小写，可以有空格
 */
+ (NSNumber *)lf_numberWithString:(NSString *)string;

/**
 如果超出9999，则折叠成 XX.X 万
 */
- (NSString *)lf_wrappedDescription;

- (NSString *)lf_toDecimalStyleString;

@end
