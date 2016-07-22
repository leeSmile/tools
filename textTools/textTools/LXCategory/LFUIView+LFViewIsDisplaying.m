//
//  UIView+LFViewIsDisplaying.m
//  LaiFeng
//
//  Created by Ton on 15/12/3.
//  Copyright © 2015年 live Interactive. All rights reserved.
//

#import "LFUIView+LFViewIsDisplaying.h"

@implementation UIView (LFViewIsDisplayingAdditons)
- (BOOL)lf_isDisplayedInScreen {
    if (self == nil) {
        return FALSE;
    }
    
    CGRect screenRect = [UIScreen mainScreen].bounds;
    
    CGRect rect = [self convertRect:self.frame fromView:nil];
    if (CGRectIsEmpty(rect) || CGRectIsNull(rect)) {
        return FALSE;
    }
    
    if (self.hidden) {
        return FALSE;
    }
    
    if (self.superview == nil) {
        return FALSE;
    }
    
    if (CGSizeEqualToSize(rect.size, CGSizeZero)) {
        return  FALSE;
    }
    
    CGRect intersectionRect = CGRectIntersection(rect, screenRect);
    if (CGRectIsEmpty(intersectionRect) || CGRectIsNull(intersectionRect)) {
        return FALSE;
    }
    
    return TRUE;
}
@end
