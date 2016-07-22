//
//  UIImage+CutScreen.m
//  LaiFeng
//
//  Created by jiangsongwen on 16/4/18.
//  Copyright © 2016年 live Interactive. All rights reserved.
//

#import "LFUIImage+CutScreen.h"

@implementation UIImage (LFCutScreenAdditions)

+ (UIImage *)lf_cutScreen{
    return [self cutFromView:[UIApplication sharedApplication].keyWindow];
}

+ (UIImage *)cutFromView:(UIView *)view{

    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    
    [[UIColor clearColor] setFill];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();
//    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    return image;
    
}
@end
