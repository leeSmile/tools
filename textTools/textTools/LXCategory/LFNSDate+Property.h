//
//  NSDate+LFAdd.m
//
//
//  Created by guoyaoyuan on 13-4-11.
//  Copyright (c) 2013 live Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Provides extensions for `NSDate`.
 */
@interface NSDate (LFPropertyAdditions)


#pragma mark - 时间部分
///=============================================================================
/// @name 时间部分
///=============================================================================

@property (nonatomic, readonly) NSInteger lf_year; ///< Year component
@property (nonatomic, readonly) NSInteger lf_month; ///< Month component
@property (nonatomic, readonly) NSInteger lf_day; ///< Day component
@property (nonatomic, readonly) NSInteger lf_hour; ///< Hour component
@property (nonatomic, readonly) NSInteger lf_minute; ///< Minute component
@property (nonatomic, readonly) NSInteger lf_second; ///< Second component
@property (nonatomic, readonly) NSInteger lf_nanosecond; ///< Nanosecond component
@property (nonatomic, readonly) NSInteger lf_weekday; ///< Weekday component
@property (nonatomic, readonly) NSInteger lf_weekdayOrdinal; ///< WeekdayOrdinal component
@property (nonatomic, readonly) NSInteger lf_weekOfMonth; ///< WeekOfMonth component
@property (nonatomic, readonly) NSInteger lf_weekOfYear; ///< WeekOfYear component
@property (nonatomic, readonly) NSInteger lf_yearForWeekOfYear; ///< YearForWeekOfYear component
@property (nonatomic, readonly) NSInteger lf_quarter; ///< Quarter component
@property (nonatomic, readonly) BOOL lf_isLeapMonth; ///< 是否闰月
@property (nonatomic, readonly) BOOL lf_isLeapYear; ///< 是否闰年

@end
