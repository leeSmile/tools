//
//  UIViewController+DKAnalyses.m
//  GCDDemo
//
//  Created by wangxiaoxiang on 16/3/31.
//  Copyright © 2016年 wangxiaoxiang. All rights reserved.
//


#if DEBUG
#import "LFUIViewController+DKAnalyses.h"
#import <objc/runtime.h>


NSMutableDictionary *g_alloc_count_dictionary = nil;

@implementation UIViewController (LFDKAnalysesAdditions)


+(NSDictionary *)lf_allocAnalysesDictionary
{
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    
    for(NSString *key in g_alloc_count_dictionary.allKeys){
        NSNumber *number = g_alloc_count_dictionary[key];
        if(number.integerValue > 0 && key.length >= 3 && ![[key substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"UI"]
           && ![[key substringWithRange:NSMakeRange(0, 3)] isEqualToString:@"_UI"]
           ){
            [result setObject:g_alloc_count_dictionary[key] forKey:key];
        }
    }
    
    return result;
}

+ (void)load
{
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_alloc_count_dictionary = [[NSMutableDictionary alloc] init];
        //1
        SEL originSEL  = NSSelectorFromString(@"dealloc");
        Method origin_dealloc_Method =  class_getInstanceMethod([UIViewController class],originSEL);
        Method dk_dealloc_Method = class_getInstanceMethod([UIViewController class], @selector(dk_dealloc));
        method_exchangeImplementations(dk_dealloc_Method, origin_dealloc_Method);

        //2
        Method origin_alloc_Method =  class_getInstanceMethod([UIViewController class], @selector(initWithNibName:bundle:));
        Method dk_alloc_Method = class_getInstanceMethod([UIViewController class], @selector(dk_initWithNibName:bundle:));
        method_exchangeImplementations(dk_alloc_Method, origin_alloc_Method);
    });
}

- (void)dk_dealloc
{
    NSNumber *number = g_alloc_count_dictionary[NSStringFromClass([self class])];
    g_alloc_count_dictionary[NSStringFromClass([self class])] = @(number.unsignedLongLongValue - 1);
    [self dk_dealloc];
}

- (instancetype)dk_initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSNumber *number = g_alloc_count_dictionary[NSStringFromClass([self class])];
    g_alloc_count_dictionary[NSStringFromClass([self class])] = @(number.unsignedLongLongValue + 1);
    return [self dk_initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
}



@end

#endif
