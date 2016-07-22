//
//  NSDictionary+NSDictionaryExt.m
//  LaiFeng
//
//  Created by xinliu on 14-5-20.
//  Copyright (c) 2014年 live Interactive. All rights reserved.
//

#import "LFNSDictionary+Add.h"
#import "LFCategory.h"


@implementation NSDictionary (LFModelValueAdditions)

-(NSTimeInterval)lf_timeIntervalForKey:(NSString *)key withDefault:(NSTimeInterval)defVal{
    @try {
        return [[self objectForKey:key] doubleValue];
    }
    @catch (NSException *exception) {
        return defVal;
    }
}

- (NSDate *)lf_timestampDataForKey:(NSString *)key withDefault:(NSDate *)defVal {
    if (self[key]) {
        SInt64 timestamp = [self lf_longLongForKey:key withDefault:0];
        if (timestamp == 0) return nil;
        return [NSDate dateWithTimeIntervalSince1970:timestamp / 1000.0];
    } else {
        return defVal;
    }
}


- (NSString*)lf_queryString {
	NSMutableString* buffer = [[NSMutableString alloc] initWithCapacity:0];
	for (id key in self) {
		NSString* value = [NSString stringWithFormat:@"%@",[self objectForKey:key]];
		value = [value lf_urlEncode2:NSUTF8StringEncoding];
		[buffer appendString:[NSString stringWithFormat:@"&%@=%@", key, value]];
	}
	NSString* ret = [buffer substringFromIndex:1];

	return ret;
}

- (id)lf_objectForKey:(NSString*)key class:(Class)aClass
{
    id obj = self[key];
    if ([obj isKindOfClass:aClass]) {
        return obj;
    }
    return nil;
}




#pragma mark - Dictionary Value Getter
///=============================================================================
/// @name Dictionary Value Getter
///=============================================================================

/// Get a number value from 'id'.
static NSNumber *NSNumberFromID(id value) {
    static NSCharacterSet *dot;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dot = [NSCharacterSet characterSetWithRange:NSMakeRange('.', 1)];
    });
    if (!value || value == [NSNull null]) return nil;
    if ([value isKindOfClass:[NSNumber class]]) return value;
    if ([value isKindOfClass:[NSString class]]) {
        NSString *lower = ((NSString *)value).lowercaseString;
        if ([lower isEqualToString:@"true"] || [lower isEqualToString:@"yes"]) return @(YES);
        if ([lower isEqualToString:@"false"] || [lower isEqualToString:@"no"]) return @(NO);
        if ([lower isEqualToString:@"nil"] || [lower isEqualToString:@"null"]) return nil;
        if ([lower isEqualToString:@"<nil>"] || [lower isEqualToString:@"<null>"]) return nil;
        if ([(NSString *)value rangeOfCharacterFromSet:dot].location != NSNotFound) {
            return @(((NSString *)value).doubleValue);
        } else {
            return @(((NSString *)value).longLongValue);
        }
    }
    return nil;
}

#define RETURN_VALUE(_type_)                          \
    if (!key) return def;                             \
    id value = self[key];                             \
    if (!value || value == [NSNull null]) return def; \
    if ([value isKindOfClass:[NSNumber class]])       \
        return ((NSNumber *)value)._type_;            \
    if ([value isKindOfClass:[NSString class]]) {     \
        NSNumber *num = NSNumberFromID(value);        \
        if (!num) return def;                         \
        return num._type_;                            \
    }                                                 \
    return def;

- (BOOL)lf_boolForKey:(NSString *)key withDefault:(BOOL)def {
    RETURN_VALUE(boolValue);
}

- (char)lf_charForKey:(NSString *)key withDefault:(char)def {
    RETURN_VALUE(charValue);
}

- (unsigned char)lf_unsignedCharForKey:(NSString *)key withDefault:(unsigned char)def {
    RETURN_VALUE(unsignedCharValue);
}

- (short)lf_shortForKey:(NSString *)key withDefault:(short)def {
    RETURN_VALUE(shortValue);
}

- (unsigned short)lf_unsignedShortForKey:(NSString *)key withDefault:(unsigned short)def {
    RETURN_VALUE(unsignedShortValue);
}

- (int)lf_intForKey:(NSString *)key withDefault:(int)def {
    RETURN_VALUE(intValue);
}

- (unsigned int)lf_unsignedIntForKey:(NSString *)key withDefault:(unsigned int)def {
    RETURN_VALUE(unsignedIntValue);
}

- (long)lf_longForKey:(NSString *)key withDefault:(long)def {
    RETURN_VALUE(longValue);
}

- (unsigned long)lf_unsignedLongForKey:(NSString *)key withDefault:(unsigned long)def {
    RETURN_VALUE(unsignedLongValue);
}

- (long long)lf_longLongForKey:(NSString *)key withDefault:(long long)def {
    RETURN_VALUE(longLongValue);
}

- (unsigned long long)lf_unsignedLongLongForKey:(NSString *)key withDefault:(unsigned long long)def {
    RETURN_VALUE(unsignedLongLongValue);
}

- (float)lf_floatForKey:(NSString *)key withDefault:(float)def {
    RETURN_VALUE(floatValue);
}

- (double)lf_doubleForKey:(NSString *)key withDefault:(double)def {
    RETURN_VALUE(doubleValue);
}

- (NSInteger)lf_integerForKey:(NSString *)key withDefault:(NSInteger)def {
    RETURN_VALUE(integerValue);
}

- (NSUInteger)lf_unsignedIntegerForKey:(NSString *)key withDefault:(NSUInteger)def {
    RETURN_VALUE(unsignedIntegerValue);
}

- (NSNumber *)lf_numberForKey:(NSString *)key withDefault:(NSNumber *)def {
    if (!key) return def;
    id value = self[key];
    if (!value || value == [NSNull null]) return def;
    if ([value isKindOfClass:[NSNumber class]]) return value;
    if ([value isKindOfClass:[NSString class]]) {
        NSNumber *num = NSNumberFromID(value);
        if (!num) num = def;
        return num;
    }
    return def;
}

- (NSString *)lf_stringForKey:(NSString *)key withDefault:(NSString *)def {
    if (!key) return def;
    id value = self[key];
    if (!value || value == [NSNull null]) return def;
    if ([value isKindOfClass:[NSString class]]) return value;
    if ([value isKindOfClass:[NSNumber class]]) return ((NSNumber *)value).stringValue;
    if ([value isKindOfClass:[NSURL class]]) return ((NSURL *)value).absoluteString;
    return def;
}

- (BOOL)lf_boolForKey:(NSString *)key; {return [self lf_boolForKey:key withDefault:NO];}
- (char)lf_charForKey:(NSString *)key; {return [self lf_charForKey:key withDefault:NO];}
- (unsigned char)lf_unsignedCharForKey:(NSString *)key; {return [self lf_unsignedCharForKey:key withDefault:0];}
- (short)lf_shortForKey:(NSString *)key; {return [self lf_shortForKey:key withDefault:0];}
- (unsigned short)lf_unsignedShortForKey:(NSString *)key; {return [self lf_unsignedShortForKey:key withDefault:0];}
- (int)lf_intForKey:(NSString *)key; {return [self lf_intForKey:key withDefault:0];}
- (unsigned int)lf_unsignedIntForKey:(NSString *)key; {return [self lf_unsignedIntForKey:key withDefault:0];}
- (long)lf_longForKey:(NSString *)key; {return [self lf_longForKey:key withDefault:0];}
- (unsigned long)lf_unsignedLongForKey:(NSString *)key; {return [self lf_unsignedLongForKey:key withDefault:0];}
- (long long)lf_longLongForKey:(NSString *)key; {return [self lf_longLongForKey:key withDefault:0];}
- (unsigned long long)lf_unsignedLongLongForKey:(NSString *)key; {return [self lf_unsignedLongLongForKey:key withDefault:0];}
- (float)lf_floatForKey:(NSString *)key; {return [self lf_floatForKey:key withDefault:0];}
- (double)lf_doubleForKey:(NSString *)key; {return [self lf_doubleForKey:key withDefault:0];}
- (NSInteger)lf_integerForKey:(NSString *)key; {return [self lf_integerForKey:key withDefault:0];}
- (NSUInteger)lf_unsignedIntegerForKey:(NSString *)key; {return [self lf_unsignedIntegerForKey:key withDefault:0];}
- (NSNumber *)lf_numberForKey:(NSString *)key; {return [self lf_numberForKey:key withDefault:nil];}
- (NSString *)lf_stringForKey:(NSString *)key; {return [self lf_stringForKey:key withDefault:nil];}

@end
