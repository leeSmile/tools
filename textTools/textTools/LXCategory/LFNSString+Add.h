//
//  NSString+Add.h
//
//
//  Created by guoyaoyuan on 13-4-3.
//  Copyright (c) 2013 live Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_STATIC_INLINE BOOL NSStringIsEmpty(NSString *string)
{
    if (string == nil || string.length == 0) {
        return YES;
    }
    return NO;
}

/**
 哈希，加密，解码等功能
 */
@interface NSString (LFAdditions)

#pragma mark - Hash
///=============================================================================
/// @name Hash
///=============================================================================

/// md5 小写
- (NSString *)lf_md5;

/// md2 小写
- (NSString *)lf_md2String;
/// md4 小写
- (NSString *)lf_md4String;
/// md5 小写
- (NSString *)lf_md5String;
/// sha1 小写
- (NSString *)lf_sha1String;
/// sha224 小写
- (NSString *)lf_sha224String;
/// sha256 小写
- (NSString *)lf_sha256String;
/// sha384 小写
- (NSString *)lf_sha384String;
/// sha512 小写
- (NSString *)lf_sha512String;

/// hmac (md5) 小写
- (NSString *)lf_hmacMD5StringWithKey:(NSString *)key;
/// hmac (sha1) 小写
- (NSString *)lf_hmacSHA1StringWithKey:(NSString *)key;
/// hmac (sha224) 小写
- (NSString *)lf_hmacSHA224StringWithKey:(NSString *)key;
/// hmac (sha256) 小写
- (NSString *)lf_hmacSHA256StringWithKey:(NSString *)key;
/// hmac (sha384) 小写
- (NSString *)lf_hmacSHA384StringWithKey:(NSString *)key;
/// hmac (sha512) 小写
- (NSString *)lf_hmacSHA512StringWithKey:(NSString *)key;

/// crc32 小写
- (NSString *)crc32String;


#pragma mark - 编码解码
///=============================================================================
/// @name 编码解码
///=============================================================================

/// URL encode (UTF8)
- (NSString *)lf_stringByURLEncode;
/// URL decode (UTF8)
- (NSString *)lf_stringByURLDecode;

/// URL encode
- (NSString *)lf_stringByURLEncode:(NSStringEncoding)encoding;
/// URL decode
- (NSString *)lf_stringByURLDecode:(NSStringEncoding)encoding;

/// 将html字符转义。 例如将 '<' 转为 '&lt;'
- (NSString *)lf_stringByEscapingHTML;

#pragma mark - 绘制
///=============================================================================
/// @name 绘制
///=============================================================================


/// 计算字符串的绘制大小
- (CGSize)lf_sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;

/// 计算字符串的绘制宽度 (单行)
- (CGFloat)lf_widthForFont:(UIFont *)font;

/// 计算字符串的绘制高度 (定宽)
- (CGFloat)lf_heightForFont:(UIFont *)font width:(CGFloat)width;

/// 计算字符串的绘制高度
/// @param width 最大宽度
/// @param maxLine 最大行数 (比如传入3，则字超过3行时，会截取3行的高度返回)
- (CGFloat)lf_heightForFont:(UIFont *)font width:(CGFloat)width line:(NSInteger)maxLine;

#pragma mark - 正则表达式
///=============================================================================
/// @name 正则表达式
///=============================================================================

/// 是否能匹配一个正则
- (BOOL)lf_matchesRegex:(NSString *)regex;

/// 遍历所有正则匹配
/// @param match 匹配的 subString
/// @param index 第几个匹配 (从0开始)
/// @param matchRange 匹配的 subString 的范围
/// @param stop 设置为NO则停止遍历
- (void)lf_enumerateRegexMatches:(NSString *)regex usingBlock:(void (^)(NSString *match, NSInteger index, NSRange matchRange, BOOL *stop))block;

- (void)lf_enumerateRegexMatches:(NSString *)regex caseInsensitive:(BOOL)caseIns usingBlock:(void (^)(NSString *match, NSInteger index, NSRange matchRange, BOOL *stop))block;

/// 查找并替换所有(正则)
- (NSString *)lf_stringByReplacingRegex:(NSString *)regex withString:(NSString *)replacement;


#pragma mark - Emoji
///=============================================================================
/// @name Emoji
///=============================================================================

/// 是否包含表情
- (BOOL)lf_containsEmoji;

/// 所有表情: @"😄😃..."
+ (NSString *)lf_allEmoji;

/// 根据分组返回表情: @"😄😃...";
/// @param group 表情分组, 目前苹果支持: @"people" @"nature" @"object" @"places" @"symbols"
+ (NSString *)lf_allEmojiByGroup:(NSString *)group;

/// 所有表情 NSArray: @[@"😄",@"😃",...];
+ (NSArray *)lf_allEmojiArray;

/// 根据分组返回表情 NSArray: @"😄😃...";
/// @param group 表情分组, 目前苹果支持: @"people" @"nature" @"object" @"places" @"symbols"
+ (NSArray *)lf_allEmojiArrayByGroup:(NSString *)group;


#pragma mark - Utilities
///=============================================================================
/// @name Utilities
///=============================================================================

/// 返回一个随机 UUID 例如 "D1178E50-2A4D-4F1F-9BD3-F6AAB00E06B1"
+ (NSString *)lf_stringWithUUID;

/// 切去头尾的空白字符 (空格/换行等)
- (NSString *)lf_stringByTrim;

/**
 为文件名添加 @2x, @3x 的后缀: @"name" -> @"name@2x"
 这里假设没有扩展名
 
 e.g.
 <table>
 <tr><th>Before     </th><th>After(scale:2)</th></tr>
 <tr><td>"icon"     </td><td>"icon@2x"     </td></tr>
 <tr><td>"icon "    </td><td>"icon @2x"    </td></tr>
 <tr><td>"icon.top" </td><td>"icon.top@2x" </td></tr>
 <tr><td>"/p/name"  </td><td>"/p/name@2x"  </td></tr>
 <tr><td>"/path/"   </td><td>"/path/"      </td></tr>
 </table>
 
 @param scale Resource scale.
 @return String by add scale modifier, or just return if it's not end with file name.
 */
- (NSString *)lf_stringByAppendingNameScale:(CGFloat)scale;

/**
 为完整文件名添加 @2x, @3x 后缀: @"name.png" -> @"name@2x.png"
 这里假设有扩展名
 
 e.g.
 <table>
 <tr><th>Before     </th><th>After(scale:2)</th></tr>
 <tr><td>"icon.png" </td><td>"icon@2x.png" </td></tr>
 <tr><td>"icon..png"</td><td>"icon.@2x.png"</td></tr>
 <tr><td>"icon"     </td><td>"icon@2x"     </td></tr>
 <tr><td>"icon "    </td><td>"icon @2x"    </td></tr>
 <tr><td>"icon."    </td><td>"icon.@2x"    </td></tr>
 <tr><td>"/p/name"  </td><td>"/p/name@2x"  </td></tr>
 <tr><td>"/path/"   </td><td>"/path/"      </td></tr>
 </table>
 
 @param scale Resource scale.
 @return String by add scale modifier, or just return if it's not end with file name.
 */
- (NSString *)lf_stringByAppendingPathScale:(CGFloat)scale;

/**
 解析字符串的scale.
 例如 icon@2x.png 返回 2.
 
 e.g.
 <table>
 <tr><th>Path            </th><th>Scale </th></tr>
 <tr><td>"icon.png"      </td><td>1     </td></tr>
 <tr><td>"icon@2x.png"   </td><td>2     </td></tr>
 <tr><td>"icon@2.5x.png" </td><td>2.5   </td></tr>
 <tr><td>"icon@2x"       </td><td>1     </td></tr>
 <tr><td>"icon@2x..png"  </td><td>1     </td></tr>
 <tr><td>"icon@2x.png/"  </td><td>1     </td></tr>
 </table>
 */
- (CGFloat)lf_pathScale;

/// 是否非空 (例如 nil, @"", @"  ", @"\n" 返回 NO)
- (BOOL)lf_isNotBlank;

/// 是否包含字符串
- (BOOL)lf_containsString:(NSString *)string;

/// 是否包含 charset 中的字符
- (BOOL)lf_containsCharacterSet:(NSCharacterSet *)set;

/// 解析为NSNumber。 支持各种格式，例如：@"123" @".12f" @" 0x12FF "
- (NSNumber *)lf_numberValue;

/// 以 UTF8 编码，转为NSData
- (NSData *)lf_dataValue;

/// 解析 json 字符串，返回 NSDictionary/NSArray。 (解析失败返回nil)
- (id)lf_jsonValueDecoded;

/// 从 Main bundle 的文件创建字符串，(类似 [UIImage imageNamed:])
- (NSString *)lf_stringNamed:(NSString *)name;

// liyuan+ 数字字符串用逗号分隔
- (NSString *)lf_segmentString;


@end
