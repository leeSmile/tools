//
//  NSObject+LFAddForNotification.m
//  LaiFeng
//
//  Created by guoyaoyuan on 16/2/23.
//  Copyright © 2016年 live Interactive. All rights reserved.
//

#import "LFNSObject+AddForNotification.h"
#import "LFWeakProxy.h"
#import <objc/runtime.h>

@implementation NSObject (LFAddForNotification)

- (NSMutableDictionary *)_lf_observersForNotification {
    NSMutableDictionary *targets = objc_getAssociatedObject(self, _cmd);
    if (!targets) {
        targets = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return targets;
}

- (void)lf_addNotifName:(NSString *)notifName block:(void(^)(NSNotification *notif))block {
    if (!notifName || !block) return;
    NSObject *observer = [[NSNotificationCenter defaultCenter] addObserverForName:notifName object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        block(note);
    }];
    NSMutableArray *obs = [self _lf_observersForNotification][notifName];
    if (!obs) {
        obs = [NSMutableArray new];
        [self _lf_observersForNotification][notifName] = obs;
    }
    [obs addObject:[LFWeakProxy proxyWithTarget:observer]];
}

- (void)lf_removeNotifName:(NSString *)notifName {
    if (!notifName) return;
    NSMutableArray *obs = [self _lf_observersForNotification][notifName];
    for (LFWeakProxy *proxy in obs) {
        if (proxy.target) {
            [[NSNotificationCenter defaultCenter] removeObserver:proxy.target];
        }
    }
    [[self _lf_observersForNotification] removeObjectForKey:notifName];
}

- (void)lf_removeAllNotif {
    [[self _lf_observersForNotification] enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSMutableArray *obs, BOOL *stop) {
        for (LFWeakProxy *proxy in obs) {
            if (proxy.target) {
                [[NSNotificationCenter defaultCenter] removeObserver:proxy.target];
            }
        }
    }];
    [[self _lf_observersForNotification] removeAllObjects];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
