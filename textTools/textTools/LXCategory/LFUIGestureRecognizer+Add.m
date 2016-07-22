//
//  UIGestureRecognizer+LFAdd.m
//
//
//  Created by guoyaoyuan on 14-10-13.
//  Copyright (c) 2014 live Interactive. All rights reserved.
//

#import "LFUIGestureRecognizer+Add.h"
#import "LFCategoryMacro.h"
#import <objc/runtime.h>

static const int block_key;

@interface _LFUIGestureRecognizerBlockTarget : NSObject

@property (nonatomic, copy) void (^block)(id sender);

- (id)initWithBlock:(void (^)(id sender))block;
- (void)invoke:(id)sender;

@end

@implementation _LFUIGestureRecognizerBlockTarget

- (id)initWithBlock:(void (^)(id sender))block{
    self = [super init];
    if (self) {
        self.block = block;
    }
    return self;
}

- (void)invoke:(id)sender {
    if (self.block) self.block(sender);
}


@end




@implementation UIGestureRecognizer (LFAdditions)

- (instancetype)initWithActionBlock:(void (^)(id sender))block {
    self = [self init];
    [self lf_addActionBlock:block];
    return self;
}

- (void)lf_addActionBlock:(void (^)(id sender))block {
    _LFUIGestureRecognizerBlockTarget *target = [[_LFUIGestureRecognizerBlockTarget alloc] initWithBlock:block];
    [self addTarget:target action:@selector(invoke:)];
    NSMutableArray *targets = [self _lf_allUIGestureRecognizerBlockTargets];
    [targets addObject:target];
}

- (void)lf_removeAllActionBlocks{
    NSMutableArray *targets = [self _lf_allUIGestureRecognizerBlockTargets];
    [targets enumerateObjectsUsingBlock:^(id target, NSUInteger idx, BOOL *stop) {
        [self removeTarget:target action:@selector(invoke:)];
    }];
    [targets removeAllObjects];
}

- (NSMutableArray *)_lf_allUIGestureRecognizerBlockTargets {
    NSMutableArray *targets = objc_getAssociatedObject(self, &block_key);
    if (!targets) {
        targets = [NSMutableArray array];
        objc_setAssociatedObject(self, &block_key, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return targets;
}

@end
