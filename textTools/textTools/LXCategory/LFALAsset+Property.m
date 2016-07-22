//
//  ALAsset+LFAdd.m
//  LaiFeng
//
//  Created by liuxin on 15/1/12.
//  Copyright (c) 2015年 live Interactive. All rights reserved.
//

#import "LFALAsset+Property.h"


@implementation ALAsset (LFALAssetPopertyAdditions)



// 图片资源唯一的标示
- (NSString *)lf_uniqueId
{
    return [NSString stringWithFormat:@"%@%f", [self uniqueFileName], [self lf_timeIntervalSince1970]];
}

// 比较两个图片资源指向的对象是否相等
- (BOOL)lf_isEqual:(id)other
{
    if (other == self)
        return YES;
    
    if (!other || ![other isKindOfClass:[self class]])
        return NO;
    
    if (self.lf_timeIntervalSince1970 == ((ALAsset *)other).lf_timeIntervalSince1970) { // 比较拍摄时间
        NSString* selfUniqueFileName = self.uniqueFileName;
        NSString* otherUniqueFileName = ((ALAsset *)other).uniqueFileName;
        return [selfUniqueFileName isEqualToString:otherUniqueFileName];     // 比较文件名
    }
    
    return NO;
}

// 唯一图片资源的文件名
- (NSString *)uniqueFileName
{
    NSString *path = [self defaultRepresentation].url.relativeString;
    NSArray  *pathList = [path componentsSeparatedByString: @"/"];
    NSString *filteName = (NSString *)[pathList lastObject];
    return filteName;
}

// 图片属性日期
- (NSDate *)propertyDate
{
    NSDate * date = [self valueForProperty:ALAssetPropertyDate];
    return [date copy];
}

// 图片资源的拍摄时间
- (NSTimeInterval)lf_timeIntervalSince1970
{
    NSDate * date = [self valueForProperty:ALAssetPropertyDate];
    return [date timeIntervalSince1970];
}

@end
