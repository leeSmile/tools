//
//  UIView+DKAnalyses.m
//  GCDDemo
//
//  Created by wangxiaoxiang on 16/3/31.
//  Copyright © 2016年 wangxiaoxiang. All rights reserved.
//


#if DEBUG
#import "LFUIView+DKAnalyses.h"
#import <objc/runtime.h>


NSMutableDictionary *g_alloc_count_views_dictionary = nil;

@implementation UIView (LFDKAnalysesAdditions)


+(NSDictionary *)lf_allocAnalysesViewsDictionary
{
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    
    for(NSString *key in g_alloc_count_views_dictionary.allKeys){
        NSNumber *number = g_alloc_count_views_dictionary[key];
        if(number.integerValue > 0 && key.length >= 3 && ![[key substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"UI"]
           && ![[key substringWithRange:NSMakeRange(0, 3)] isEqualToString:@"_UI"]
           ){
            [result setObject:g_alloc_count_views_dictionary[key] forKey:key];
        }
    }
    
    return result;
}

+ (void)load
{
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_alloc_count_views_dictionary = [[NSMutableDictionary alloc] init];
        //1
        SEL originSEL  = NSSelectorFromString(@"dealloc");
        Method origin_dealloc_Method =  class_getInstanceMethod([UIView class],originSEL);
        Method dk_dealloc_Method = class_getInstanceMethod([UIView class], @selector(dk_dealloc));
        method_exchangeImplementations(dk_dealloc_Method, origin_dealloc_Method);

        //2
        Method origin_alloc_Method =  class_getInstanceMethod([UIView class], @selector(initWithFrame:));
        Method dk_alloc_Method = class_getInstanceMethod([UIView class], @selector(dk_initWithName:));
        method_exchangeImplementations(dk_alloc_Method, origin_alloc_Method);
    });
}

- (void)dk_dealloc
{
    NSNumber *number = g_alloc_count_views_dictionary[NSStringFromClass([self class])];
    g_alloc_count_views_dictionary[NSStringFromClass([self class])] = @(number.unsignedLongLongValue - 1);
    [self dk_dealloc];
}

- (instancetype)dk_initWithName:(CGRect)frame
{
    NSNumber *number = g_alloc_count_views_dictionary[NSStringFromClass([self class])];
    g_alloc_count_views_dictionary[NSStringFromClass([self class])] = @(number.unsignedLongLongValue + 1);
    return [self dk_initWithName:frame];
}



@end

#endif
