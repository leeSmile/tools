
#import <UIKit/UIKit.h>

@interface UIBarButtonItem (LXExtension)
+ (instancetype)lx_itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
