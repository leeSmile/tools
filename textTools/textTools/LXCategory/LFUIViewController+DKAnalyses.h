//
//  UIViewController+DKAnalyses.h
//  GCDDemo
//
//  Created by wangxiaoxiang on 16/3/31.
//  Copyright © 2016年 wangxiaoxiang. All rights reserved.
//



#if DEBUG
#import <UIKit/UIKit.h>

@interface UIViewController (LFDKAnalysesAdditions)

+(NSDictionary *)lf_allocAnalysesDictionary;

@end

#endif
