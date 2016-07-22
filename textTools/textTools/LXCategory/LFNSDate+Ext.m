//
//  NSDate+NSDateExt.m
//  LaiFeng
//
//  Created by xinliu on 14-6-25.
//  Copyright (c) 2014年 live Interactive. All rights reserved.
//

#import "LFNSDate+Ext.h"
#import <CoreText/CoreText.h>
#import "LFNSDate+Format.h"
#import "LFNSDate+Update.h"
#import "LFNSDate+Property.h"

@implementation NSDate(LFExtAdditions)
- (NSString*) lf_stringForTimeLaifeng {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"MM月dd日 HH:mm"];
	NSString *timeStr = [formatter stringFromDate:self];
	return timeStr;
}

- (NSString*)lf_stringForHourLaifeng {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    NSString *timeStr = [formatter stringFromDate:self];
    return timeStr;
}

- (NSString*)lf_stringForDayLaifeng {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd"];
    NSString *timeStr = [formatter stringFromDate:self];
    return timeStr;
}

- (NSString*) lf_stringForTimeToday {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"今天 HH:mm"];
	NSString *timeStr = [formatter stringFromDate:self];
	return timeStr;
}

- (NSString *)lf_stringForTimeTomorrow {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"明天 HH:mm"];
    NSString *timeStr = [formatter stringFromDate:self];
    return timeStr;
}

- (NSString *)lf_stringForTimeCommon {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM月dd日 HH:mm"];
    NSString *timeStr = [formatter stringFromDate:self];
    return timeStr;
}

-(NSAttributedString*) lf_attributedStringForTimeToday {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"今天 HH:mm"];
    NSString *timeStr = [formatter stringFromDate:self];
    
    NSMutableAttributedString* attributedString = [[NSMutableAttributedString alloc] initWithString:timeStr];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,2)];
    return attributedString;
}

-(NSAttributedString*) lf_attributedStringForTimeTomorrow {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"明天 HH:mm"];
    NSString *timeStr = [formatter stringFromDate:self];
    
    NSMutableAttributedString* attributedString = [[NSMutableAttributedString alloc] initWithString:timeStr];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,2)];
    return attributedString;
}

-(NSAttributedString*) lf_attributedStringForCommon {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM月dd日 HH:mm"];
    NSString *timeStr = [formatter stringFromDate:self];
    NSMutableAttributedString* attributedString = [[NSMutableAttributedString alloc] initWithString:timeStr];
    return attributedString;
}

- (NSString*) lf_stringForDateline {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd"];
	NSString* str = [formatter stringFromDate:self];
	return str;
}

- (NSString *)lf_stringForFeed {
    
    
    static NSDateFormatter *formatterToday;
    static NSDateFormatter *formatterYesterday;
    static NSDateFormatter *formatterSameYear;
    static NSDateFormatter *formatterNormal;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatterToday = [[NSDateFormatter alloc] init];
        [formatterToday setDateFormat:@"今天 HH:mm"];
        [formatterToday setLocale:[NSLocale currentLocale]];
        
        formatterYesterday = [[NSDateFormatter alloc] init];
        [formatterYesterday setDateFormat:@"昨天 HH:mm"];
        [formatterYesterday setLocale:[NSLocale currentLocale]];
        
        formatterSameYear = [[NSDateFormatter alloc] init];
        [formatterSameYear setDateFormat:@"MM-dd HH:mm"];
        [formatterSameYear setLocale:[NSLocale currentLocale]];
        
        formatterNormal = [[NSDateFormatter alloc] init];
        [formatterNormal setDateFormat:@"yyyy-MM-dd HH:mm"];
        [formatterNormal setLocale:[NSLocale currentLocale]];
    });
    
    
    NSDate *now = [NSDate new];
    NSTimeInterval delta = now.timeIntervalSince1970 - self.timeIntervalSince1970;
    if (self.lf_isToday && delta > -60 * 5) { //如果服务端和客户端时间不同步，这里允许5分钟误差
        if (delta < 5 * 60) {
            return @"刚刚";
        } else if (delta < 10 * 60) {
            return @"5分钟前";
        } else if (delta < 20 * 60) {
            return @"10分钟前";
        } else if (delta < 30 * 60) {
            return @"20分钟前";
        } else if (delta < 45 * 60) {
            return @"半小时前";
        } else if (delta < 60) {
            return @"1小时前";
        } else {
            return [formatterToday stringFromDate:self];
        }
    } else if (self.lf_isYesterday) {
        return [formatterYesterday stringFromDate:self];
    } else if (now.lf_year == self.lf_year){
        return [formatterSameYear stringFromDate:self];
    } else {
        return [formatterNormal stringFromDate:self];
    }
}

- (BOOL)lf_isToday {
    NSDate *date = [NSDate new];
    return (date.lf_year == self.lf_year && date.lf_month == self.lf_month && date.lf_day == self.lf_day);
}
- (BOOL)lf_isYesterday {
    return [[self lf_dateByAddingDays:1] lf_isToday];
}
- (BOOL)lf_isTodayBirthday {
    NSDate *date = [NSDate new];
    return (date.lf_month == self.lf_month && date.lf_day == self.lf_day);
}
-(BOOL)lf_isLast30Mins {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    NSString *timeStr = [formatter stringFromDate:self];
    NSArray* kvPair = [timeStr componentsSeparatedByString:@":"];
    if([kvPair[0] integerValue] >= 23 && [kvPair[1] integerValue] >= 30) {
        return YES;
    }
    return NO;
}

@end
