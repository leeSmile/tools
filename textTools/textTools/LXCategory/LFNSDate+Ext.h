//
//  NSDate+NSDateExt.h
//  LaiFeng
//
//  Created by xinliu on 14-6-25.
//  Copyright (c) 2014年 live Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NSDate(NSDateExt)
- (NSString *)lf_stringForTimeLaifeng;
- (NSString *)lf_stringForDateline;
- (NSString *)lf_stringForTimeToday;
- (NSString *)lf_stringForTimeTomorrow;
- (NSString *)lf_stringForTimeCommon;
- (NSString *)lf_stringForHourLaifeng;
- (NSString *)lf_stringForDayLaifeng;
- (NSAttributedString *)lf_attributedStringForTimeToday;
- (NSAttributedString *)lf_attributedStringForTimeTomorrow;
- (NSAttributedString *)lf_attributedStringForCommon;

- (NSString *)lf_stringForFeed;
- (BOOL)lf_isToday;
- (BOOL)lf_isYesterday;
- (BOOL)lf_isTodayBirthday;
- (BOOL)lf_isLast30Mins;
@end
