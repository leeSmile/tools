//
//  NSObject+LFAddForNotification.h
//  LaiFeng
//
//  Created by guoyaoyuan on 16/2/23.
//  Copyright © 2016年 live Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (LFAddForNotification)

- (void)lf_addNotifName:(NSString *)notifName block:(void(^)(NSNotification *notif))block;
- (void)lf_removeNotifName:(NSString *)notifName;
- (void)lf_removeAllNotif;

@end
