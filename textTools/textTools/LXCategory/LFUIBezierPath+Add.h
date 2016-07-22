//
//  UIBezierPath+LFAdd.h
// 
//
//  Created by guoyaoyuan on 14/10/30.
//  Copyright (c) 2014 live Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Provides extensions for `UIBezierPath`.
 */
@interface UIBezierPath (LFAdditions)

/**
 用文本创建贝塞尔曲线。 曲线是描绘了文字的边缘。(可以做一些有趣的效果)
 
 @discussion 这里只支持纯文本。 如果要emoji，用下面这个方法：
 [UIImage imageWithEmoji:size:] in `UIImage(LFAdd)`.
 
 @param text The text to generate glyph path.
 @param font The font to generate glyph path.
 @return A new path object with the text and font, or nil when an error occurs.
 */
+ (UIBezierPath *)lf_bezierPathWithText:(NSString *)text font:(UIFont *)font;

@end
