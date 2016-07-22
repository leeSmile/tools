//
//  UIViewController+LFAdd.m
//  LaiFeng
//
//  Created by limingchen on 15/6/30.
//  Copyright (c) 2015年 live Interactive. All rights reserved.
//

#import "LFUIViewController+Add.h"
#import <objc/runtime.h>

@implementation UIViewController (LFAdditions)

static const void *_hidesNavigationBarWhenPushed = &_hidesNavigationBarWhenPushed;

- (void)setHidesNavigationBarWhenPushed:(BOOL)hidesNavigationBarWhenPushed {
    objc_setAssociatedObject(self, _hidesNavigationBarWhenPushed, @(hidesNavigationBarWhenPushed), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)hidesNavigationBarWhenPushed {
    return [objc_getAssociatedObject(self, _hidesNavigationBarWhenPushed) boolValue];
}

@end
