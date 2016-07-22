//
//  NSString+Ex.h
//  LaiFeng
//
//  Created by xinliu on 14-5-16.
//  Copyright (c) 2014年 live Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(LFURLStringAdditions)

- (NSString*) lf_urlEncode2:(NSStringEncoding)stringEncoding;

+ (BOOL)lf_stringIsNull:(NSString *)string;

- (NSString*) lf_urlDecode:(NSStringEncoding)stringEncoding;
- (NSDictionary*)lf_queryContentsDicUsingEncoding:(NSStringEncoding)encoding;

- (NSURL*)lf_toURL;
@end
