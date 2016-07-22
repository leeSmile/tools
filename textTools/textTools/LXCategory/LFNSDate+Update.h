//
//  NSDate+Update.h
//  LFCategory
//
//  Created by WangZhiWei on 16/5/19.
//  Copyright © 2016年 youku. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LFUpdateAdditions)

#pragma mark - 日期修改
///=============================================================================
/// @name 日期修改
///=============================================================================


- (NSDate *)lf_dateByAddingYears:(NSInteger)years; /// 从这个日期加上N年
- (NSDate *)lf_dateByAddingMonths:(NSInteger)months; /// 从这个日期加上N月
- (NSDate *)lf_dateByAddingWeeks:(NSInteger)weeks; /// 从这个日期加上N日
- (NSDate *)lf_dateByAddingDays:(NSInteger)days; /// 从这个日期加上N天
- (NSDate *)lf_dateByAddingHours:(NSInteger)hours; /// 从这个日期加上N小时
- (NSDate *)lf_dateByAddingMinutes:(NSInteger)minutes; /// 从这个日期加上N分钟
- (NSDate *)lf_dateByAddingSeconds:(NSInteger)seconds; /// 从这个日期加上N秒


@end
