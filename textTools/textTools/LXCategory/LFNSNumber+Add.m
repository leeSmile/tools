//
//  NSNumber+LFAdd.m
//
//
//  Created by guoyaoyuan on 13-8-24.
//  Copyright (c) 2013 live Interactive. All rights reserved.
//

#import "LFNSNumber+Add.h"
#import "LFNSString+Add.h"
#import "LFCategoryMacro.h"


@implementation NSNumber (LFAdditions)

+ (NSNumber *)lf_numberWithString:(NSString *)string {
    NSString *str = [[string lf_stringByTrim] lowercaseString];
    if (!str || !str.length) {
        return nil;
    }
    
    // hex number
    int sign = 0;
    if ([str hasPrefix:@"0x"]) sign = 1;
    else if ([str hasPrefix:@"-0x"]) sign = -1;
    if (sign != 0) {
        NSScanner *scan = [NSScanner scannerWithString:str];
        unsigned num = -1;
        BOOL suc = [scan scanHexInt:&num];
        if (suc)
            return [NSNumber numberWithLong:((long)num * sign)];
        else
            return nil;
    }
    
    // normal number
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    return [formatter numberFromString:string];
}

- (NSString *)lf_wrappedDescription {
    if (self.longLongValue <= 9999) {
        return self.description;
    } else {
        return [NSString stringWithFormat:@"%.1f万",(self.longLongValue)/(10000.0)];
    }
}


- (NSString *)lf_toDecimalStyleString
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    return [numberFormatter stringFromNumber:self];
}

@end
