//
//  UIView+Badge.m
//  LaiFeng
//
//  Created by limingchen on 15/8/11.
//  Copyright (c) 2015年 live Interactive. All rights reserved.
//
#import <objc/runtime.h>
#import "LFUIView+Badge.h"
#import "LFCategory.h"

//< 亲自测量 default   width = {20 27 35 } height = {20}  system
#define LF_BADGE_VIEW_REDDOT_WIDTH          ((sizeType == LFBadgeSizeTypeNormal) ? 8.0 : 8.0)
#define LF_BADGE_VIEW_HEIGHT                ((sizeType == LFBadgeSizeTypeNormal) ? 15.0 : 15.0)
#define LF_BADGE_VIEW_SAMLL_WIDTH           ((sizeType == LFBadgeSizeTypeNormal) ? 15.0 : 15.0)
#define LF_BADGE_VIEW_STANDARD_WIDTH        ((sizeType == LFBadgeSizeTypeNormal) ? 22.0 : 22.0)
#define LF_BADGE_VIEW_BIG_WIDTH             ((sizeType == LFBadgeSizeTypeNormal) ? 27.0 : 27.0)

#define LF_BADGE_VIEW_NEW_FONT              ((sizeType == LFBadgeSizeTypeNormal) ? 10.0 : 10.0)
#define LF_BADGE_VIEW_NUMBER_FONT           ((sizeType == LFBadgeSizeTypeNormal) ? 12.0 : 12.0)

//key for associative methods during runtime
static char badgeLabelKey;
static char badgeOriginXKey;
static char badgeOriginYKey;
static char badgeShowallNumbersKey;

@implementation UIView (LFBadgeAdditons)

#pragma mark -- public methods

/**
 *  clear badge
 */
- (void)lf_clearBadge
{
    if(self.lf_badge)  self.lf_badge.hidden = YES;
}


#pragma mark -- private methods

- (void)lf_showRedDotBadge{
    [self lf_showRedDotBadgeByStyle:LFBadgeStyleNormal sizeType:LFBadgeSizeTypeNormal];
}

- (void)lf_showRedDotBadgeBySizeType:(LFBadgeSizeType)sizeType{
    [self lf_showRedDotBadgeByStyle:LFBadgeStyleNormal sizeType:sizeType];
}

- (void)lf_showRedDotBadgeByStyle:(LFBadgeStyle)style{
    [self lf_showRedDotBadgeByStyle:style sizeType:LFBadgeSizeTypeNormal];
}

- (void)lf_showRedDotBadgeByStyle:(LFBadgeStyle)style sizeType:(LFBadgeSizeType)sizeType{
    [self configBadge:LFBadgeTypeRedDot style:style sizeType:sizeType value:0];
}

/* --showNewBadge -- */
- (void)lf_showNewBadge{
    [self lf_showNewBadgeByStyle:LFBadgeStyleNormal sizeType:LFBadgeSizeTypeNormal];
}

- (void)lf_showNewBadgeBySizeType:(LFBadgeSizeType)sizeType{
    [self lf_showNewBadgeByStyle:LFBadgeStyleNormal sizeType:sizeType];
}

- (void)lf_showNewBadgeByStyle:(LFBadgeStyle)style{
    [self lf_showNewBadgeByStyle:style sizeType:LFBadgeSizeTypeNormal];
}

- (void)lf_showNewBadgeByStyle:(LFBadgeStyle)style sizeType:(LFBadgeSizeType)sizeType{
    [self configBadge:LFBadgeTypeNew style:style sizeType:sizeType value:0];
}

/* --showNumberBadge -- */
- (void)lf_showNumberBadge:(NSInteger)value{
    [self lf_showNumberBadge:value style:LFBadgeStyleNormal sizeType:LFBadgeSizeTypeNormal];
}

- (void)lf_showNumberBadge:(NSInteger)value sizeType:(LFBadgeSizeType)sizeType{
    [self lf_showNumberBadge:value style:LFBadgeStyleNormal sizeType:sizeType];
}

- (void)lf_showNumberBadge:(NSInteger)value style:(LFBadgeStyle)style{
    [self lf_showNumberBadge:value style:style sizeType:LFBadgeSizeTypeNormal];
}

- (void)lf_showNumberBadge:(NSInteger)value style:(LFBadgeStyle)style sizeType:(LFBadgeSizeType)sizeType{
    if (!self.lf_showAllNumbers && value <= 0) {
        [self lf_clearBadge];
        return;
    }
    [self configBadge:LFBadgeTypeNumber style:style sizeType:sizeType value:value];
}


//lazy loading
- (void)badgeInit
{
    if (nil == self.lf_badge) {
        self.lf_badge = [[UILabel alloc] initWithFrame:CGRectZero];
        self.lf_badge.textAlignment = NSTextAlignmentCenter;
        self.lf_badge.backgroundColor = LFUIColorWithRGB(228,32,38);
        self.lf_badge.textColor = [UIColor whiteColor];
        self.lf_badge.text = @"";
        self.lf_badge.layer.cornerRadius = self.lf_badge.lf_width / 2;
        self.lf_badge.layer.masksToBounds = YES;//very important
        [self addSubview:self.lf_badge];
    }
}

- (void)configBadge:(LFBadgeType)type style:(LFBadgeStyle)style sizeType:(LFBadgeSizeType)sizeType value:(NSInteger)value{
    [self badgeInit];
    
    self.lf_badge.tag = type;
    
    switch (type) {
        case LFBadgeTypeRedDot:
        {
            self.lf_badge.text = @"";
            self.lf_badge.lf_width = LF_BADGE_VIEW_REDDOT_WIDTH;
            self.lf_badge.lf_height = LF_BADGE_VIEW_REDDOT_WIDTH;
        }
            break;
        case LFBadgeTypeNumber:
        {
            if (value >=100) {
                self.lf_badge.text = self.lf_showAllNumbers ? @(value).description : @"99+";
            } else {
                self.lf_badge.text = [NSString stringWithFormat:@"%@", @(value)];
            }
            
            if(value >= 100){
                self.lf_badge.lf_width = LF_BADGE_VIEW_BIG_WIDTH;
            }
            else if(value >= 10){
                self.lf_badge.lf_width = LF_BADGE_VIEW_STANDARD_WIDTH;
            }
            else{
                self.lf_badge.lf_width = LF_BADGE_VIEW_SAMLL_WIDTH;
            }
            self.lf_badge.lf_height = LF_BADGE_VIEW_HEIGHT;
            self.lf_badge.font = [UIFont systemFontOfSize:LF_BADGE_VIEW_NUMBER_FONT];
        }
            break;
        case LFBadgeTypeNew:
        {
            self.lf_badge.text = @"new";
            self.lf_badge.lf_width = LF_BADGE_VIEW_BIG_WIDTH;
            self.lf_badge.lf_height = LF_BADGE_VIEW_HEIGHT;
            self.lf_badge.font = [UIFont systemFontOfSize:LF_BADGE_VIEW_NEW_FONT];
        }
            break;
        default:
            break;
    }
    if(style == LFBadgeStyleNormal){
        self.lf_badge.center = CGPointMake(self.lf_width, 0);
    }
    else if(style == LFBadgeStyleCircle){
        CGFloat radius = self.lf_width/2;
        self.lf_badge.center = CGPointMake(ceil(radius + sqrt(2)/2*radius), ceil(radius - sqrt(2)/2*radius));
    }
    
    //*********自己定义的X Y*************//
    if([self hasBadgeOriginX]){
        self.lf_badge.lf_left = self.lf_badgeOriginX;
    }
    
    if([self hasBadgeOriginY]){
        self.lf_badge.lf_top = self.lf_badgeOriginY;
    }
    //********************************//

    self.lf_badge.layer.cornerRadius = self.lf_badge.lf_height / 2;
    self.lf_badge.hidden = NO;
}

#pragma mark -- setter/getter
- (UILabel *)lf_badge
{
    UILabel* lbl = objc_getAssociatedObject(self, &badgeLabelKey);
    if(lbl == nil) {
        lbl = [[UILabel alloc] initWithFrame:CGRectZero];
        [self setLf_badge:lbl];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.backgroundColor = LFUIColorWithRGB(228,32,38);
        lbl.textColor = [UIColor whiteColor];
        lbl.text = @"";
        lbl.layer.masksToBounds = YES;//very important
        lbl.hidden = YES;
        [self addSubview:lbl];
    }
    return lbl;
}

- (void)setLf_badge:(UILabel *)label
{
    objc_setAssociatedObject(self, &badgeLabelKey, label, OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)hasBadgeOriginX{
    return objc_getAssociatedObject(self, &badgeOriginXKey) ? YES : NO;
}

-(CGFloat) lf_badgeOriginX {
    NSNumber *number = objc_getAssociatedObject(self, &badgeOriginXKey);
    return number.floatValue;
}

-(void) setLf_badgeOriginX:(CGFloat)badgeOriginX
{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginX];
    objc_setAssociatedObject(self, &badgeOriginXKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.lf_badge.lf_left = badgeOriginX;
}

- (BOOL)hasBadgeOriginY{
    return objc_getAssociatedObject(self, &badgeOriginYKey) ? YES : NO;
}

-(CGFloat) lf_badgeOriginY {
    NSNumber *number = objc_getAssociatedObject(self, &badgeOriginYKey);
    return number.floatValue;
}

- (BOOL) lf_showAllNumbers{
    return objc_getAssociatedObject(self, &badgeShowallNumbersKey) ? YES : NO;
}

- (void) setLf_showAllNumbers:(BOOL)showAllNumbers{
    NSNumber *number = [NSNumber numberWithBool:showAllNumbers];
    objc_setAssociatedObject(self, &badgeShowallNumbersKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void) setLf_badgeOriginY:(CGFloat)badgeOriginY
{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginY];
    objc_setAssociatedObject(self, &badgeOriginYKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.lf_badge.lf_top = badgeOriginY;
}

- (LFBadgeType)lf_getBadgeType{
    if(self.lf_badge){
        return [self.lf_badge tag];
    }
    return LFBadgeTypeRedDot;
}

- (BOOL)lf_isShowBage {

    return self.lf_badge.hidden;
}

@end
