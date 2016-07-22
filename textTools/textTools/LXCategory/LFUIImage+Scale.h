//
//  UIImage+Addtional.h
//  LaiFeng
//
//  Created by xinliu on 14-5-29.
//  Copyright (c) 2014年 live Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage (LFScaleAdditions)
// 缩放图片
//scale 适应于位图的缩放系数。如果制定这个值为0.0，那么这个缩放系数就被设置成设备主屏幕的缩放系数
+ (UIImage *)lf_scaleImage:(UIImage *)image scaleToSize:(CGSize)size scale:(CGFloat)scale;

+ (UIImage*)lf_clipImage:(UIImage *)originalImage rect:(CGRect)rect;

//中间拉伸自动宽高
//+ (UIImage*)middleStretchableImageWithKey:(NSString*)key ;
//中间拉伸图片,不支持换肤
+ (UIImage *)lf_middleStretchableImageWithOutSupportSkin:(NSString *)key;

+ (UIImage *)lf_createRoundedRectImage:(UIImage*)image size:(CGSize)size cornerRadius:(CGFloat)radius;

// 缩放图片并且剧中截取
+ (UIImage *)lf_middleScaleImage:(UIImage *)image scaleToSize:(CGSize)size;
//宽高取小缩放，取大居中截取
+ (UIImage *)lf_suitableScaleImage:(UIImage *)image scaleToSize:(CGSize)size;
//等比缩放到多少倍
+ (UIImage *)lf_scaleImage:(UIImage *)image toScale:(float)scaleSize;
//等比例缩放
+(UIImage*)lf_scaleToSize:(UIImage*)image size:(CGSize)size;
// zhengzheng
//等比缩放
+ (UIImage *) lf_scaleImageForImage:(UIImage *)image toScale:(float)scaleSize;
- (UIImage *)lf_fixOrientation;

+ (UIImage *)lf_cutIntoImageToSquare:(UIImage *)image;

//截取部分图像(区分高分屏或者低分屏)
/* ++++++++++++++++++++++++++++++++++++++
 *
 * zhengzheng
 
 @param img 需要被截取的图片
 @param scale  倍率（低分屏1.0 高分屏2.0）
 @param rect 截取的范围
 @return 返回截取后的图片
 */
+ (UIImage*)lf_getSubImage:(UIImage *)img scale:(CGFloat)scale rect:(CGRect)rect;
/* ------------------------------------- */

// 判断是否超长超宽图（宽高比大于4）
+ (BOOL)lf_isLongwidePhoto:(UIImage*)image;

// 将宽高比大于4的图，截取顶部的宽高 1：2 的部分
+ (UIImage*)lf_longwidePhotoToNormal:(UIImage*)image;

+ (UIImage *)lf_compressImageIfNeed:(UIImage *)originImage;

/**
 * @brief 裁剪图片
 * @param image 需要裁剪的图片
 * @param size 需要裁剪的长度和宽度（两者都是size）
 * @returns 裁剪后的图片
 */
+ (UIImage *)lf_scaleAndRotateImage:(UIImage *)image size:(NSInteger)size;

+ (CGSize)lf_imageSizeWithData:(NSData *)data;

@end
