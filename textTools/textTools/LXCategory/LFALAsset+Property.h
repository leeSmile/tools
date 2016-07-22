//
//  ALAsset+Compare.h
//  LaiFeng
//
//  Created by liuxin on 15/1/12.
//  Copyright (c) 2015年 live Interactive. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import <UIKit/UIKit.h>

/**
 * @brief 图片资源比较类别
 */
@interface ALAsset (LFALAssetPopertyAdditions)

/**
 * @brief 比较两个图片资源指向的对象是否相等
 * @param other 其他的图片资源
 * @returns YES 相等，否则 NO
 */
- (BOOL)lf_isEqual:(id)other;

/**
 * @brief 图片资源唯一的标示
 * @returns 唯一的图片资源id
 */
- (NSString *)lf_uniqueId;

/**
 * @brief 图片资源的拍摄时间
 * @returns 拍摄时间
 */
- (NSTimeInterval)lf_timeIntervalSince1970;

@end