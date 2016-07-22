//
//  NSString+Currency.m
//  LaiFeng
//
//  Created by Ton on 16/3/14.
//  Copyright © 2016年 live Interactive. All rights reserved.
//

#import "LFNSString+Currency.h"

@implementation NSString (LFCurrencyAdditions)

- (NSString *)lf_localizedStringFromNumber {
    if(![self isKindOfClass:[NSString class]]){
        return self;
    }
    float oldf = [self floatValue];
    long long oldll = [self longLongValue];
    float tmptf = oldf - oldll;
    NSString *currencyStr = nil;
    if(tmptf > 0){
        currencyStr = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithFloat:oldll]
                                                       numberStyle:NSNumberFormatterDecimalStyle];
    }else{
        currencyStr = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithLongLong:oldll]
                                                       numberStyle:NSNumberFormatterDecimalStyle];
    }
    return currencyStr;
}@end
