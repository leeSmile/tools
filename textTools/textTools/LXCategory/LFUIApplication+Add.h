//
//  UIApplication+LFAdd.h
//
//
//  Created by guoyaoyuan on 13-4-4.
//  Copyright (c) 2013 live Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

/// Returns "Documents" folder in this app's sandbox.
NSString *NSDocumentsPath(void);

/// Returns "Library" folder in this app's sandbox.
NSString *NSLibraryPath(void);

/// Returns "Caches" folder in this app's sandbox.
NSString *NSCachesPath(void);


/**
 Provides extensions for `UIApplication`.
 */
@interface UIApplication (LFAdditions)

/// "Documents" folder in this app's sandbox.
@property (nonatomic, readonly,getter=lf_documentsURL) NSURL *documentsURL;

/// "Caches" folder in this app's sandbox.
@property (nonatomic, readonly, getter=lf_cachesURL) NSURL *cachesURL;

/// "Library" folder in this app's sandbox.
@property (nonatomic, readonly, getter=lf_libraryURL) NSURL *libraryURL;

/// Application's Bundle Name (show in SpringBoard).
@property (nonatomic, readonly, getter=lf_appBundleName) NSString *appBundleName;

/// Application's Bundle ID.  e.g. "com.live Interactive.MyApp"
@property (nonatomic, readonly, getter=lf_appBundleID) NSString *appBundleID;

/// Application's Version.  e.g. "1.2.0"
@property (nonatomic, readonly, getter=lf_appVersion) NSString *appVersion;

/// Application's Build number. e.g. "123"
@property (nonatomic, readonly, getter=lf_appBuildVersion) NSString *appBuildVersion;

/// Current thread real memory used in byte. (-1 when error occurs)
@property (nonatomic, readonly, getter=lf_memoryUsage) int64_t memoryUsage;

/// Current thread CPU usage, 1.0 means 100%. (-1 when error occurs)
@property (nonatomic, readonly, getter=lf_cpuUsage) float cpuUsage;


/// App是否被破解了
/// Whether this app is priated (not from appstore).
@property (nonatomic, readonly, getter=lf_isPirated) BOOL isPirated;

/// App是否正在被调试
/// Whether this app is being debugged (debugger attached).
@property (nonatomic, readonly, getter=lf_isBeingDebugged) BOOL isBeingDebugged;

@end
