//
//  LFALAsset+Image.h
//  LFCategory
//
//  Created by WangZhiWei on 16/5/19.
//  Copyright © 2016年 youku. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import <UIKit/UIKit.h>

/**
 * @brief 获取图片资源相应的图片
 */
@interface ALAsset (LFALAssetImageAdditions)

/**
 * @brief 获取原始图片
 * @returns 原始图片
 */
- (UIImage *)lf_fullSizeImage;

/**
 * @brief 获取全屏尺寸的照片
 * @returns 全屏尺寸的照片
 */
- (UIImage *)lf_fullScreenImage;

@end
