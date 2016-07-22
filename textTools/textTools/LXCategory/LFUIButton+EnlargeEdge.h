//
//  UIButton+EnlargeEdge.h
//  iTalk
//
//  Created by Si Wen on 15/12/29.
//  Copyright © 2015年 Si Wen. All rights reserved.
//

#ifndef UIButton_EnlargeEdge_h
#define UIButton_EnlargeEdge_h

#import <UIKit/UIKit.h>

@interface UIButton (LFEnlargeEdgeAdditions)
- (void)lf_setEnlargeEdge:(CGFloat) size;
- (void)lf_setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;
@end

#endif
