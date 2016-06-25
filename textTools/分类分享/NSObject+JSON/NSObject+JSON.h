
#import <Foundation/Foundation.h>

@interface NSObject (JSON)

/**
 *  字典或对象转成JSON字符串数据
 */
@property (nonatomic, copy, readonly) NSString *JSONString;

@end
