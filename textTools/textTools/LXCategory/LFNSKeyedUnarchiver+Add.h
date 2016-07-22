//
//  NSKeyedUnarchiver+LFAdd.h
//
//
//  Created by guoyaoyuan on 14-8-4.
//  Copyright (c) 2014 live Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Provides extensions for `NSKeyedUnarchiver`.
 */
@interface NSKeyedUnarchiver (LFNSKeyedUnarchiverAdditions)

/**
 Same as unarchiveObjectWithData:, except it returns the exception by reference.
 
 @param data       The data need unarchived.
 
 @param exception  Pointer which will, upon return, if an exception occurred and
 said pointer is not NULL, point to said NSException.
 */
+ (id)lf_unarchiveObjectWithData:(NSData *)data exception:(__autoreleasing NSException **)exception;

/**
 Same as unarchiveObjectWithFile:, except it returns the exception by reference.
 
 @param path       The path of archived object file.
 
 @param exception  Pointer which will, upon return, if an exception occurred and
 said  pointer is not NULL, point to said NSException.
 */
+ (id)lf_unarchiveObjectWithFile:(NSString *)path exception:(__autoreleasing NSException **)exception;

@end
