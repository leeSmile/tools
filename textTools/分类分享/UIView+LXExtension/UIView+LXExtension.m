
#import "UIView+LXExtension.h"

@implementation UIView (LXExtension)
- (BOOL)lx_intersectsWithView:(UIView *)view
{
    //都先转换为相对于窗口的坐标，然后进行判断是否重合
    CGRect selfRect = [self convertRect:self.bounds toView:nil];
    CGRect viewRect = [view convertRect:view.bounds toView:nil];
    return CGRectIntersectsRect(selfRect, viewRect);
}

+ (instancetype)lx_viewFromXib
{
    
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

- (CGFloat)lx_centerX
{
    return self.center.x;
}
- (void)setLx_centerX:(CGFloat)lx_centerX
{
    CGPoint center = self.center;
    center.x = lx_centerX;
    self.center = center;
}
- (CGFloat)lx_centerY
{
    return self.center.y;
}
- (void)setLx_centerY:(CGFloat)lx_centerY
{
    CGPoint center = self.center;
    center.y = lx_centerY;
    self.center = center;
}
- (CGSize)lx_size
{
    return self.frame.size;
}

- (void)setLx_size:(CGSize)lx_size
{
    CGRect frame = self.frame;
    frame.size = lx_size;
    self.frame = frame;
}

- (CGFloat)lx_width
{
    return self.frame.size.width;
}

- (CGFloat)lx_height
{
    return self.frame.size.height;
}

- (void)setLx_width:(CGFloat)lx_width
{
    CGRect frame = self.frame;
    frame.size.width = lx_width;
    self.frame = frame;
}
- (void)setLx_height:(CGFloat)lx_height
{
    CGRect frame = self.frame;
    frame.size.height = lx_height;
    self.frame = frame;
}

- (CGFloat)lx_x
{
    return self.frame.origin.x;
}

- (void)setLx_x:(CGFloat)lx_x
{
    CGRect frame = self.frame;
    frame.origin.x = lx_x;
    self.frame = frame;
}

- (CGFloat)lx_y
{
    return self.frame.origin.y;
}

- (void)setLx_y:(CGFloat)lx_y
{
    CGRect frame = self.frame;
    frame.origin.y = lx_y;
    self.frame = frame;
}

@end
