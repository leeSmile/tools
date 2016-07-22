//
//  UIBarButtonItem+LFAdd.m
//
//
//  Created by guoyaoyuan on 14-10-15.
//  Copyright (c) 2014 live Interactive. All rights reserved.
//

#import "LFUIBarButtonItem+Add.h"
#import "LFCategoryMacro.h"
#import <objc/runtime.h>


static const int block_key;

@interface _LFUIBarButtonItemBlockTarget : NSObject

@property (nonatomic, copy) void (^block)(id sender);

- (id)initWithBlock:(void (^)(id sender))block;
- (void)invoke:(id)sender;

@end

@implementation _LFUIBarButtonItemBlockTarget

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


@implementation UIBarButtonItem (LFAdditions)

- (void)setActionBlock:(void (^)(id sender))block {
    _LFUIBarButtonItemBlockTarget *target = [[_LFUIBarButtonItemBlockTarget alloc] initWithBlock:block];
    objc_setAssociatedObject(self, &block_key, target, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self setTarget:target];
    [self setAction:@selector(invoke:)];
}

- (void (^)(id)) actionBlock {
    _LFUIBarButtonItemBlockTarget *target = objc_getAssociatedObject(self, &block_key);
    return target.block;
}

@end
