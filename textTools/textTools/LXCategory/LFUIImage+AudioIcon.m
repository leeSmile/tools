//
//  UIImage+AudioIcon.m
//  LaiFeng
//
//  Created by jiangsongwen on 16/4/5.
//  Copyright © 2016年 live Interactive. All rights reserved.
//

#import "LFUIImage+AudioIcon.h"

@implementation UIImage (LFAudioIconAdditions)
-(UIImage*)lf_bringAutoIconImage
{
    UIGraphicsBeginImageContextWithOptions(self.size, 0, 1);
    
    [self drawAtPoint:CGPointMake(0, 0)];
    
    CGFloat Radius = 15;
    //三角形
    CGFloat polygonRadius = 10;
    
    [[UIColor lightGrayColor] set];
    
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    UIBezierPath *beizierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.size.width*0.5, self.size.height*0.5) radius:Radius startAngle:0 endAngle:2*M_PI clockwise:0];
    
    CGContextSetLineWidth(ctx, 2);
    
    CGContextAddPath(ctx, beizierPath.CGPath);
    
    CGContextStrokePath(ctx);
    
    CGContextMoveToPoint(ctx, 0, 0);
    CGContextAddLineToPoint(ctx, 10, 10);
    
    CGFloat width= polygonRadius;
    
    CGRect rect = CGRectMake((self.size.width-width)*0.5, (self.size.height-width)*0.5, width, width);
    
    [self drawPolygonWithRect:rect andEdge:3 andOffset:1 ctx:ctx];
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return image;
}


-(void)drawPolygonWithRect:(CGRect)rect andEdge:(NSInteger)edgeCount andOffset:(NSInteger)offset  ctx:(CGContextRef)ctx
{
    CGFloat lineW = 1.0;
    
    CGContextSetLineWidth(ctx, lineW);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    
    //添加圆
    CGFloat centerX = CGRectGetMidX(rect);
    CGFloat centerY = CGRectGetMidY(rect);
    CGFloat radius = rect.size.width - lineW*0.5;
    
    
    NSInteger count = edgeCount;
    CGFloat unitAngle = 2*M_PI/count;
    CGFloat tempAngle = 0;
    
    for (NSInteger i =0;i<count+1; i++) {
        CGFloat calAngle = 0;
        NSInteger flag = 0;
        if (tempAngle >= M_PI_2*3) {//四区间
            calAngle = M_PI*2 - tempAngle;
            flag = 0;
        }else if(tempAngle >= M_PI)//三区间
        {
            calAngle =  tempAngle - M_PI ;
            flag= 1;
        }else if(tempAngle >= M_PI_2)//二区间
        {
            calAngle  = M_PI - tempAngle;
            flag =2;
        }else //一区间
        {
            calAngle = tempAngle;
            flag = 3;
        }
        
        CGFloat height = sin(calAngle)*radius;
        CGFloat width =  cos(calAngle)*radius;
        if (calAngle==0) {
            height=0;
            width = radius;
        }else if (calAngle==M_PI_2)
        {
            height=radius;
            width =0;
        }
        
        
        if (i==0) {
            CGContextMoveToPoint(ctx, centerX+width, height+centerY);
        }else
        {
            switch (flag) {
                case 0://4
                    CGContextAddLineToPoint(ctx, centerX+width,centerY-height);
                    break;
                case 1://3
                    CGContextAddLineToPoint(ctx, centerX-width,centerY-height);
                    break;
                case 2://2
                    CGContextAddLineToPoint(ctx, centerX-width,centerY+height);
                    break;
                case 3://1
                    CGContextAddLineToPoint(ctx, centerX+width,centerY+height);
                    break;
            }
        }
        
        tempAngle = tempAngle + unitAngle*offset;
        
    }
    
    
    //    CGContextStrokePath(ctx);
    
    CGContextFillPath(ctx);
    
}

@end
