//
//  UIBarButtonItem+LFAdd.h
//
//
//  Created by guoyaoyuan on 14-10-15.
//  Copyright (c) 2014 live Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Provides extensions for `UIBarButtonItem`.
 */
@interface UIBarButtonItem (LFAdditions)

/**
 The block that invoked when the item is selected. The objects captured by block
 will retained by the ButtonItem.
 
 @discussion This param is conflict with `target` and `action` property.
 Set this will set `target` and `action` property to some internal objects.
 */
@property (nonatomic, copy) void (^actionBlock)(id);

@end
