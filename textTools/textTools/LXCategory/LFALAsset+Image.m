//
//  LFALAsset+Image.m
//  LFCategory
//
//  Created by WangZhiWei on 16/5/19.
//  Copyright © 2016年 youku. All rights reserved.
//

#import "LFALAsset+Image.h"
#import "LFCategoryMacro.h"
#import <ImageIO/ImageIO.h>
#import "LFUIImage+Scale.h"


@implementation ALAsset (LFALAssetImageAdditions)

const CGFloat kHDImageMaxLength         = 1204.0f;      // 高清图片最大的长度（长度和宽度）
const CGFloat kHDImageMaxHeight         = 12040.0f;     // 高清图片最大的高度

// 获取原始图片
- (UIImage *)lf_fullSizeImage
{
    return [self imageForMaxSize:kHDImageMaxLength];
}

// 获取全屏尺寸的照片
- (UIImage *)lf_fullScreenImage
{
    return [UIImage imageWithCGImage:[self.defaultRepresentation fullScreenImage]];
}

#pragma mark - private methods

// 获取maxSize大小的图片
- (UIImage *)imageForMaxSize:(CGFloat)maxSize
{
    ALAssetRepresentation *assetRepresentation = self.defaultRepresentation;
    if ([assetRepresentation.metadata objectForKey:@"AdjustmentXMP"]) {
        //解析图片裁剪信息，发送的时候需要手动兼容，系统相机的裁剪，以便发送裁剪之后的图片
        //不如直接久返回屏幕大小的图片不会有影响用户体验，否则解析AdjustmentXMPH比较麻烦
        return [UIImage imageWithCGImage:[assetRepresentation fullScreenImage]];
    }
    UIImage *image = [self originImageForMaxSize:maxSize];
    if(!image) image = [UIImage imageWithCGImage:[assetRepresentation fullScreenImage]];
    return image;
}

// 根据maxSize裁剪图片大小
- (UIImage *)originImageForMaxSize:(CGFloat)maxSize
{
    NSTimeInterval time = [[NSDate date]timeIntervalSince1970];
    ALAsset *asset = self;
    ALAssetRepresentation *assetRepresentation = asset.defaultRepresentation;
    UIImage *result = nil;
    NSData *data = nil;
    
    uint8_t *buffer = (uint8_t *)malloc((size_t)(sizeof(uint8_t)*[assetRepresentation size]));
    if (buffer != NULL) {
        NSError *error = nil;
        NSUInteger bytesRead = (NSUInteger)[assetRepresentation getBytes:buffer fromOffset:0 length:(NSUInteger)[assetRepresentation size] error:&error];
        data = [NSData dataWithBytes:buffer length:bytesRead];
        if (error) {
            _UTKDevLog(@"读取照片错误 %@",error.localizedDescription);
        }
        free(buffer);
    }
    
    if ([data length]) {
        CGImageSourceRef sourceRef = CGImageSourceCreateWithData((__bridge CFDataRef)data, nil);
        NSMutableDictionary *options = [NSMutableDictionary dictionary];
        [options setObject:(id)kCFBooleanTrue
                    forKey:(id)kCGImageSourceShouldAllowFloat];
        [options setObject:(id)kCFBooleanTrue
                    forKey:(id)kCGImageSourceCreateThumbnailFromImageAlways];
        
        CGFloat width;
        CGFloat height;
        CGSize size = CGSizeZero;
        if ([assetRepresentation respondsToSelector:@selector(dimensions)]) {
            size = [assetRepresentation dimensions];
        }else{
            size = [UIImage lf_imageSizeWithData:data];
        }
        width = size.width;
        height = size.height;
        
        CGFloat newHeight = maxSize;
        CGFloat newWidth = maxSize;
        //超宽和超长图片需要放宽最大限制
        if (width / height >= kSuperImageRatio || height / width >= kSuperImageRatio) {
            if (width > kHDImageMaxLength) {
                newWidth = kHDImageMaxLength;
                newHeight = height / width * newWidth;
            }else{
                newWidth = width;
                newHeight = height;
            }
        }
        //最大的长图高度10240防止上传超大图片
        if (newHeight > kHDImageMaxHeight) {
            newHeight = kHDImageMaxHeight;
            newWidth =  newHeight * width / height ;
        }
        
        //设置最大的读入图片大小
        CGFloat newMaxSize = MAX(newHeight, newWidth);
        [options setObject:(id)[NSNumber numberWithFloat:newMaxSize]
                    forKey:(id)kCGImageSourceThumbnailMaxPixelSize];
        CGImageRef imageRef = CGImageSourceCreateThumbnailAtIndex(sourceRef,
                                                                  0,
                                                                  (__bridge CFDictionaryRef)options);
        if (imageRef) {
            result = [UIImage imageWithCGImage:imageRef
                                         scale:[assetRepresentation scale]
                                   orientation:(UIImageOrientation)[assetRepresentation orientation]];
            CGImageRelease(imageRef);
        }
        
        if (sourceRef) CFRelease(sourceRef);
    }
    _UTKDevLog(@"读入的原始图片大小为：%@",NSStringFromCGSize(result.size));
    time = [[NSDate date] timeIntervalSince1970] - time;
    _UTKDevLog(@"maxSize %f 图片读入的时间为 %f",maxSize,time);
    return result;
}

@end
