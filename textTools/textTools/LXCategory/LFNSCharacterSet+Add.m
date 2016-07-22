//
//  NSCharacterSet+LFAdd.m
//
//
//  Created by guoyaoyuan on 14-10-28.
//  Copyright (c) 2014 live Interactive. All rights reserved.
//

#import "LFNSCharacterSet+Add.h"
#import "LFNSString+Add.h"
#import "LFCategoryMacro.h"


@implementation NSCharacterSet (LFNSCharacterSetAdditions)

+ (NSCharacterSet *)lf_emojiCharacterSet {
    static NSCharacterSet *set = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        set = [NSCharacterSet characterSetWithCharactersInString:[NSString lf_allEmoji]];
    });
    return set;
}

@end


@implementation NSMutableCharacterSet (LFAdd)

+ (NSMutableCharacterSet *)lf_emojiCharacterSet {
    static NSMutableCharacterSet *set = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        set = [NSCharacterSet lf_emojiCharacterSet].mutableCopy;
    });
    return set;
}

@end
