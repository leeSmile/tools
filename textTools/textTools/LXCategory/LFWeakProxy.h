//
//  LFWeakProxy.h
//
//
//  Created by guoyaoyuan on 14/10/18.
//  Copyright (c) 2014 live Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 用来打破 strong reference circle... 比如 CADisplayLink / NSTimer
@interface LFWeakProxy : NSProxy

@property (nonatomic, weak, readonly) id target;

- (instancetype)initWithTarget:(id)target;

+ (instancetype)proxyWithTarget:(id)target;

@end
