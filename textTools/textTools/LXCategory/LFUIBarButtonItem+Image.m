//
//  UIBarButtonItem+Image.m
//  LaiFeng
//
//  Created by xinliu on 14-4-25.
//  Copyright (c) 2014年 live Interactive. All rights reserved.
//

#import "LFUIBarButtonItem+Image.h"
#import "LFCategory.h"


@implementation UIBarButtonItem (LFCustomImageAdditions)

- (void)lf_setButtonAttribute:(NSDictionary*)dic
{
    if ([self.customView isKindOfClass:[UIButton class]]) {
        UIButton* button = (UIButton*)self.customView;
        UIFont* font = [dic objectForKey:@"font"];
        if (font != nil && [font isKindOfClass:[UIFont class]]) {
            [button.titleLabel setFont:font];
        }
        NSNumber* shadowOffset = [dic objectForKey:@"shadowOffset"];
        if (shadowOffset != nil && [shadowOffset isKindOfClass:[NSNumber class]]) {
            [button.titleLabel setShadowOffset:shadowOffset.CGSizeValue];
        }
        NSNumber* buttonWidth = [dic objectForKey:@"width"];
        if (buttonWidth != nil && [buttonWidth isKindOfClass:[NSNumber class]]) {
            CGRect rc = button.frame;
            rc.size.width = buttonWidth.floatValue;
            button.frame = rc;
        }
        UIColor* titleColorNormal = [dic objectForKey:@"titleColorNormal"];
        if (titleColorNormal != nil && [titleColorNormal isKindOfClass:[UIColor class]]) {
            [button setTitleColor:titleColorNormal forState:UIControlStateNormal];
        }
        UIColor* shadowColorNormal = [dic objectForKey:@"shadowColorNormal"];
        if (shadowColorNormal != nil && [shadowColorNormal isKindOfClass:[UIColor class]]) {
            [button setTitleShadowColor:shadowColorNormal forState:UIControlStateNormal];
        }
        UIColor* titleColorHighlighted = [dic objectForKey:@"titleColorHighlighted"];
        if (titleColorHighlighted != nil && [titleColorHighlighted isKindOfClass:[UIColor class]]) {
            [button setTitleColor:titleColorHighlighted forState:UIControlStateHighlighted];
        }
        UIColor* shadowColorHightlighted = [dic objectForKey:@"shadowColorHightlighted"];
        if (shadowColorHightlighted != nil && [shadowColorHightlighted isKindOfClass:[UIColor class]]) {
            [button setTitleShadowColor:shadowColorHightlighted forState:UIControlStateHighlighted];
        }
    }
}

+ (UIBarButtonItem *)lf_rsBarButtonItemWithTitle:(NSString *)title
                                        image:(UIImage *)image
                             heightLightImage:(UIImage *)hlImage
                                 disableImage:(UIImage *)disImage
                                       target:(id)target
                                       action:(SEL)selector
{
    UIButton* customButton = [self lf_rsCustomBarButtonWithTitle:title
                                                        image:image
                                             heightLightImage:hlImage
                                                 disableImage:disImage
                                                       target:target
                                                       action:selector];
    CGSize sizeOfTitle = CGSizeZero;
    if (title!=nil && ![title isEqualToString:@""]) {
        sizeOfTitle = [title lf_sizeForFont:customButton.titleLabel.font size:CGSizeMake(100.0f, 22.0f) mode:NSLineBreakByTruncatingMiddle];
    }
    
    CGFloat width = 100.0f;
    CGFloat height = 44.0f;
    CGFloat x = 0.0f;
    CGFloat y = 0.0f;
    if (customButton.currentImage != nil) {
        width = customButton.currentImage.size.width;
        height = customButton.currentImage.size.height;
    }
    if (sizeOfTitle.width <= 0.0f) {
        [customButton setFrame:CGRectMake(x,
                                          y,
                                          width,
                                          height)];        
    }else {
        [customButton setFrame:CGRectMake(x,
                                          y,
                                          sizeOfTitle.width+32.0f,
                                          height)];
    }
    
//    customButton.imageEdgeInsets = UIEdgeInsetsMake(0, 14.f, 0, -14.f);
    customButton.titleEdgeInsets = UIEdgeInsetsMake(0, 30.f, 0, 0);
    customButton.titleLabel.font = [UIFont systemFontOfSize:16.f];
    
    
    UIBarButtonItem *barBtnItem  = [[UIBarButtonItem alloc] initWithCustomView:customButton];
    barBtnItem.width             = customButton.lf_width;
    return barBtnItem;
}


+ (UIBarButtonItem *)lf_rsLeftBarButtonItemWithTitle:(NSString *)title
                                            image:(UIImage *)image
                                 heightLightImage:(UIImage *)hlImage
                                     disableImage:(UIImage *)disImage
                                           target:(id)target
                                           action:(SEL)selector
{
    UIButton* customButton = [self lf_rsCustomBarButtonWithTitle:title
                                                        image:image
                                             heightLightImage:hlImage
                                                 disableImage:disImage
                                                       target:target
                                                       action:selector];
    CGSize sizeOfTitle = CGSizeZero;
    if (title!=nil && ![title isEqualToString:@""]) {
        sizeOfTitle = [title lf_sizeForFont:customButton.titleLabel.font size:CGSizeMake(100.0f, 22.0f) mode:NSLineBreakByTruncatingMiddle];
    }
    
    CGFloat width = 100.0f;
    CGFloat height = 44.0f;
    CGFloat x = 0.0f;
    CGFloat y = 0.0f;
    if (customButton.currentImage != nil) {
        width = customButton.currentImage.size.width;
        height = customButton.currentImage.size.height;
    }
    if (sizeOfTitle.width <= 0.0f) {
        [customButton setFrame:CGRectMake(x,
                                          y,
                                          width,
                                          height)];
    }else {
        [customButton setFrame:CGRectMake(x,
                                          y,
                                          sizeOfTitle.width+32.0f,
                                          height)];
    }
    customButton.titleEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    customButton.titleLabel.font = [UIFont systemFontOfSize:16.f];
    UIBarButtonItem *barBtnItem  = [[UIBarButtonItem alloc] initWithCustomView:customButton];
    barBtnItem.width             = customButton.lf_width;
    return barBtnItem;
}


+ (UIBarButtonItem *)lf_rsBarButtonItemWithBellButton:(UIButton *)bellButton
                                             image:(UIImage *)image
                                  heightLightImage:(UIImage *)hlImage
                                      disableImage:(UIImage *)disImage
                                            target:(id)target
                                            action:(SEL)selector
{
    UIButton* customButton = [self lf_rsCustomBarButtonWithTitle:nil
                                                        image:image
                                             heightLightImage:hlImage
                                                 disableImage:disImage
                                                       target:target
                                                       action:selector];
    CGSize sizeOfBellButton = CGSizeZero;
    if (bellButton!=nil  /*&& !bellButton.isHidden*/ ) {
        sizeOfBellButton = [bellButton lf_size];;
    }

    CGFloat width = 100.0f;
    CGFloat height = 44.0f;
    CGFloat x = 0.0f;
    CGFloat y = 0.0f;
    if (customButton.currentBackgroundImage != nil) {
        width = customButton.currentBackgroundImage.size.width;
        height = customButton.currentBackgroundImage.size.height;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,y,sizeOfBellButton.width + width +3,  height)];
    if (sizeOfBellButton.width <= 0.0f ) {
        [customButton setFrame:CGRectMake(x,
                                          y,
                                          width,
                                          height)];
        [view addSubview:customButton];
    }else {

        CGRect inputFrame = CGRectMake(0,0,sizeOfBellButton.width,sizeOfBellButton.height);
        bellButton.frame = CGRectIntegral(inputFrame);

        
        [customButton setFrame:CGRectMake(sizeOfBellButton.width+3,
                                          y,
                                          width,
                                          height)];
        [view addSubview:bellButton];
        [view addSubview:customButton];
    }

    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    //    barBtnItem.width = [customButton currentBackgroundImage].size.width;
    return barBtnItem;
}

+ (UIBarButtonItem *)lf_rsBarButtonItemWithTitle:(NSString *)title
                                       target:(id)target
                                       action:(SEL)selector{
    static UIImage * _navigationBarBg;
    if (!_navigationBarBg) {
        CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 44.0f);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, LFUIColorWithRGBA(0, 0, 0, 0.2f).CGColor);
        CGContextFillRect(context, rect);
        _navigationBarBg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }

    static UIImage * _navigationBarBgHl; 

    if (!_navigationBarBgHl) {
        CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 44.0f);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, LFUIColorWithRGBA(0, 0, 0, 0.4f).CGColor);
        CGContextFillRect(context, rect);
        _navigationBarBgHl = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }

    if([UIBarButtonItem isHigherIOS7]){
        return [UIBarButtonItem lf_rsBarButtonItemWithTitle:title
                                                   image:nil
                                        heightLightImage:_navigationBarBgHl
                                            disableImage:nil
                                                  target:target
                                                  action:selector];
    }else{
        return [UIBarButtonItem lf_rsBarButtonItemWithTitle:title
                                                   image:_navigationBarBg
                                        heightLightImage:_navigationBarBgHl
                                            disableImage:nil
                                                  target:target
                                                  action:selector];
    }

}

+ (UIButton*)lf_rsCustomBarButtonWithTitle:(NSString*)title
                                  image:(UIImage *)image
                       heightLightImage:(UIImage *)hlImage
                           disableImage:(UIImage *)disImage
                                 target:(id)target
                                 action:(SEL)selector
{
    UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (image != nil) {
        [customButton setImage:image forState:UIControlStateNormal];
        [customButton setBackgroundColor:[UIColor clearColor]];
    }
    else {
//        [customButton setBackgroundColor:[UIColor blueColor]];
    }
    if (hlImage != nil) {
        [customButton setImage:hlImage forState:UIControlStateHighlighted];
    }
    if (nil != disImage)
    {
        [customButton setImage:disImage forState:UIControlStateDisabled];
    }
    if (title.length <= 2) {
        [customButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    }
    else
    {
        [customButton.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
    }

    [customButton.titleLabel setShadowOffset:CGSizeMake(0.0f, 0.5f)];
    if (title!=nil && ![title isEqualToString:@""]) {
        [customButton setTitle:title forState:UIControlStateNormal];
        [customButton setTitleColor:LFUIColorWithHexRGB(0xffa000) forState:UIControlStateNormal];
        if (![UIBarButtonItem isHigherIOS7]) {
            [customButton setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
            [customButton setTitleShadowColor:LFUIColorWithRGBA(0, 0, 0, 0.4) forState:UIControlStateDisabled];
        }
    }
    [customButton setTitleColor:[LFUIColorWithHexRGB(0xffa000) colorWithAlphaComponent:0.3] forState:UIControlStateDisabled];
    [customButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return customButton;
}

+ (BOOL)isHigherIOS7
{
    NSString * requestSysVer = @"7.0";
    NSString *currentSysVer = [[UIDevice currentDevice] systemVersion];
    if ([currentSysVer compare:requestSysVer options:NSNumericSearch] != NSOrderedAscending) {
       
        return YES;
    }
    
    return NO;
}

@end


@implementation UIToolbar(UIToolbar_Image)

// 设置导航条背景图片 navigation_bar_bg.png
//- (void)setToolBarWithImageKey:(NSString *)imageKey{
//    UIImage *image = [UIImage imageForKey:imageKey];
//    [self setBackgroundImage:image forToolbarPosition:UIToolbarPositionBottom barMetrics:UIBarMetricsDefault];
//}

- (void)lf_setToolBarWithImage:(UIImage *)image
{
    [self setBackgroundImage:image forToolbarPosition:UIToolbarPositionBottom barMetrics:UIBarMetricsDefault];
}

- (void)lf_clearToolBarImage{
    [self setBackgroundImage:nil forToolbarPosition:UIToolbarPositionBottom barMetrics:UIBarMetricsDefault];
}

@end
