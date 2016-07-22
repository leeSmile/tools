//
//  NSData+LFAdd.h
//
//
//  Created by guoyaoyuan on 13-4-4.
//  Copyright (c) 2013 live Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 哈希，加密，解码等功能
 */
@interface NSData (LFHashAdditions)

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

/// md2 NSData
- (NSData *)lf_md2Data;
/// md4 NSData
- (NSData *)lf_md4Data;
/// md5 NSData
- (NSData *)lf_md5Data;
/// sha1 NSData
- (NSData *)lf_sha1Data;
/// sha224 NSData
- (NSData *)lf_sha224Data;
/// sha256 NSData
- (NSData *)lf_sha256Data;
/// sha384 NSData
- (NSData *)lf_sha384Data;
/// sha512 NSData
- (NSData *)lf_sha512Data;


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
/// hmac (md5) NSData
- (NSData *)lf_hmacMD5DataWithKey:(NSData *)key;
/// hmac (sha1) NSData
- (NSData *)lf_hmacSHA1DataWithKey:(NSData *)key;
/// hmac (sha224) NSData
- (NSData *)lf_hmacSHA224DataWithKey:(NSData *)key;
/// hmac (sha256) NSData
- (NSData *)lf_hmacSHA256DataWithKey:(NSData *)key;
/// hmac (sha384) NSData
- (NSData *)lf_hmacSHA384DataWithKey:(NSData *)key;
/// hmac (sha512) NSData
- (NSData *)lf_hmacSHA512DataWithKey:(NSData *)key;


/// crc32 小写
- (NSString *)lf_crc32String;
/// crc32
- (uint32_t)lf_crc32;

#pragma mark - Others
///=============================================================================
/// @name Others
///=============================================================================

/// 从 main bundle 里加载数据 (和 [UIImage imageNamed:] 类似).
- (NSData *)lf_dataNamed:(NSString *)name;

@end

@interface NSData (LFEncryptionAdditions)

#pragma mark - 加密解密
///=============================================================================
/// @name 加密解密
///=============================================================================

/// aes 加密
/// @param key 加密的key，长度必须是16/24/32 (128/192/256 bits)
/// @param iv  初始向量，长度必须是16 (128 bits), 允许nil。
/// @return 加密成功返回NSData，否则返回nil
- (NSData *)lf_aes256EncryptWithKey:(NSData *)key iv:(NSData *)iv;

/// aes 解密
/// @param key 加密的key，长度必须是16/24/32 (128/192/256 bits)
/// @param iv  初始向量，长度必须是16 (128 bits), 允许nil。
/// @return 解密成功返回NSData，否则返回nil
- (NSData *)lf_aes256DecryptWithkey:(NSData *)key iv:(NSData *)iv;


@end

@interface NSData (LFEncodeAddditions)

#pragma mark - 编码解码
///=============================================================================
/// @name Encode and decode
///=============================================================================


/// 用 UTF8 解码
- (NSString *)lf_utf8String;

/// 转换为大写 hex 字符串
- (NSString *)lf_hexString;

/// 用 hex 字符串(不区分大小写)创建NSData。 失败则返回nil。
+ (NSData *)lf_dataWithHexString:(NSString *)hexString;

/// 以json方式解码，返回 NSDictionary 或 NSArray。出错则返回nil
- (id)lf_jsonValueDecoded;

@end

@interface NSData (LFCompressionAdditions)

#pragma mark - 压缩解压
///=============================================================================
/// @name Inflate and deflate
///=============================================================================

/// 解压 gzip 数据
- (NSData *)lf_gzipInflate;

/// 以 gzip 压缩
- (NSData *)lf_gzipDeflate;

/// 解压 zlib 数据
- (NSData *)lf_zlibInflate;

/// 以 zlib 压缩
- (NSData *)lf_zlibDeflate;

@end

