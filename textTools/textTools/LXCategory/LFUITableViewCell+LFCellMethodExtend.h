//
//  UITableViewCell+LFCellMethodExtend.h
//  LaiFeng
//
//  Created by Ton on 15/9/11.
//  Copyright (c) 2015年 live Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, UIViewSeparatorDirection) {
    
    UIViewSeparatorDirectionTop,
    UIViewSeparatorDirectionBottom
};
@interface UITableViewCell (LFCellMethodExtendAdditions)

/**
 *  用xib创建Cell
 *
 *  @return self;
 */
+(id)lf_loadFromXib;

/**
 *  用代码创建Cell时候设置的cellIdentifier
 *
 *  @return cellIdentifier;
 */
+(NSString*)lf_cellIdentifier;
/**
 *  用代码创建Cell
 *
 *  @return self;
 */

+(id)lf_loadFromCellStyle:(UITableViewCellStyle)cellStyle;

/**
 *  填充cell的对象
 *  子类去实现
 */

- (void)lf_createSeparatorOfView:(UIView *)view Direction:(UIViewSeparatorDirection)direction edgeNum:(float)edgeNum;
@end
