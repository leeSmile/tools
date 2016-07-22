//
//  UIView+DKAnalyses.h
//  GCDDemo
//
//  Created by wangxiaoxiang on 16/3/31.
//  Copyright © 2016年 wangxiaoxiang. All rights reserved.
//



#if DEBUG
#import <UIKit/UIKit.h>

@interface UIView (LFDKAnalysesAdditions)

+(NSDictionary *)lf_allocAnalysesViewsDictionary;

@end

#endif
