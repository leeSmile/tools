//
//  UIBarButtonItem+Image.h
//  LaiFeng
//
//  Created by xinliu on 14-4-25.
//  Copyright (c) 2014年 live Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIBarButtonItem (LFCustomImageAdditions)

+ (UIBarButtonItem *)lf_rsBarButtonItemWithTitle:(NSString *)title
                                       target:(id)target
                                       action:(SEL)selector;
// 可扩展
+ (UIBarButtonItem *)lf_rsBarButtonItemWithTitle:(NSString *)title
                                        image:(UIImage *)image
                             heightLightImage:(UIImage *)hlImage
                                 disableImage:(UIImage *)disImage
                                       target:(id)target
                                       action:(SEL)selector;

+ (UIBarButtonItem *)lf_rsLeftBarButtonItemWithTitle:(NSString *)title
                                            image:(UIImage *)image
                                 heightLightImage:(UIImage *)hlImage
                                     disableImage:(UIImage *)disImage
                                           target:(id)target
                                           action:(SEL)selector;

+ (UIBarButtonItem *)lf_rsBarButtonItemWithBellButton:(UIButton *)bellButton
                                             image:(UIImage *)image
                                  heightLightImage:(UIImage *)hlImage
                                      disableImage:(UIImage *)disImage
                                            target:(id)target
                                            action:(SEL)selector;

+ (UIButton*)lf_rsCustomBarButtonWithTitle:(NSString*)title
                                  image:(UIImage *)image
                       heightLightImage:(UIImage *)hlImage
                           disableImage:(UIImage *)disImage
                                 target:(id)target
                                 action:(SEL)selector;

- (void)lf_setButtonAttribute:(NSDictionary*)dic;

@end

@interface UIToolbar(UIToolbar_Image)

// 设置底边条背景图片
//- (void)setToolBarWithImageKey:(NSString *)imageKey;

- (void)lf_setToolBarWithImage:(UIImage *)image;
// 清空底边条的背景图片，使恢复到系统默认状态
- (void)lf_clearToolBarImage;


@end

