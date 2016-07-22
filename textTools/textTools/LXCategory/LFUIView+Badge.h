//
//  UIView+Badge.h
//  LaiFeng
//
//  Created by limingchen on 15/8/11.
//  Copyright (c) 2015年 live Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark -- types definition
typedef NS_ENUM(NSUInteger, LFBadgeType)
{
    LFBadgeTypeRedDot = 0,          /* red dot type */
    LFBadgeTypeNumber,              /* badge with number */
    LFBadgeTypeNew                  /* badge with a fixed text "new" */
};

typedef NS_ENUM(NSUInteger, LFBadgeStyle)
{
    LFBadgeStyleNormal = 0,          /* badge style rectangle  */
    LFBadgeStyleCircle,              /* badge style circle */
};

typedef NS_ENUM(NSUInteger, LFBadgeSizeType) {
    LFBadgeSizeTypeNormal = 0,      /* badge size systom */
    LFBadgeSizeTypeCustom = 1       /* badge size custom */
};


#pragma mark -- badge apis

@interface UIView (LFBadgeAdditons)

@property (nonatomic, strong, setter=setLf_badge:, getter=lf_badge) UILabel *badge;
@property (nonatomic, setter=setLf_badgeOriginX:, getter=lf_badgeOriginX) CGFloat badgeOriginX;
@property (nonatomic, getter=lf_badgeOriginY, setter=setLf_badgeOriginY:) CGFloat badgeOriginY;
@property (nonatomic, getter=lf_showAllNumbers, setter=setLf_showAllNumbers:) BOOL showAllNumbers;//<展示完整的数字 (默认超过100展示99+)  等于0也展示


/**
 *  show badge with red dot style and WBadgeAnimTypeNone by default.
 */
- (void)lf_showRedDotBadge;
- (void)lf_showRedDotBadgeBySizeType:(LFBadgeSizeType)sizeType;
- (void)lf_showRedDotBadgeByStyle:(LFBadgeStyle)style;
- (void)lf_showRedDotBadgeByStyle:(LFBadgeStyle)style sizeType:(LFBadgeSizeType)sizeType;

/**
 * show badge with WBadgeStyleNumber style
 */
- (void)lf_showNewBadge;
- (void)lf_showNewBadgeBySizeType:(LFBadgeSizeType)sizeType;
- (void)lf_showNewBadgeByStyle:(LFBadgeStyle)style;
- (void)lf_showNewBadgeByStyle:(LFBadgeStyle)style sizeType:(LFBadgeSizeType)sizeType;

/**
 * show badge with showNumberBadgeWithValue style
 */
- (void)lf_showNumberBadge:(NSInteger)value;
- (void)lf_showNumberBadge:(NSInteger)value sizeType:(LFBadgeSizeType)sizeType;
- (void)lf_showNumberBadge:(NSInteger)value style:(LFBadgeStyle)style;
- (void)lf_showNumberBadge:(NSInteger)value style:(LFBadgeStyle)style sizeType:(LFBadgeSizeType)sizeType;

/**
 *  clear badge
 */
- (void)lf_clearBadge;

/**
 *  get current badgeType
 */
- (LFBadgeType)lf_getBadgeType;

/**
 *  get bage show
 *
 */

- (BOOL)lf_isShowBage;

@end
