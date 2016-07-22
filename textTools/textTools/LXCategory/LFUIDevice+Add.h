//
//  UIDevice+Add.h
//
//
//  Created by guoyaoyuan on 13-4-3.
//  Copyright (c) 2013 live Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <mach/host_info.h>
/**
 Provides extensions for `UIDevice`.
 */

typedef void (^ cameraAuthorziedBlock) (void);

@interface UIDevice (LFAdditions)



#pragma mark - Device Information
///=============================================================================
/// @name Device Information
///=============================================================================

/// Whether the device is iPad/iPad mini.
@property (nonatomic, readonly, getter=lf_isPad) BOOL isPad;

/// Whether the device is a simulator.
@property (nonatomic, readonly, getter=lf_isSimulator) BOOL isSimulator;

/// Wherher the device can make phone calls.
@property (nonatomic, readonly, getter=lf_canMakePhoneCalls) BOOL canMakePhoneCalls;

/// The device's machine model.  e.g. "iPhone6,1" "iPad4,6"
/// @see http://theiphonewiki.com/wiki/Models
@property (nonatomic, readonly, getter=lf_machineModel) NSString *machineModel;

/// The device's machine model name. e.g. "iPhone 5s" "iPad mini 2"
/// @see http://theiphonewiki.com/wiki/Models
@property (nonatomic, readonly, getter=lf_machineModelName) NSString *machineModelName;

/// 屏幕大小，高大于宽
+ (CGSize) lf_screenSize;

/// 系统版本，以float形式返回
- (CGFloat)lf_systemVersionByFloat;

/// 系统版本，以float形式返回
+ (CGFloat)lf_systemVersionByFloat;

#pragma mark - Disk Space
///=============================================================================
/// @name Disk Space
///=============================================================================

/// Total disk space in byte. (-1 when error occurs)
@property (nonatomic, readonly, getter=lf_diskSpace) int64_t diskSpace;

/// Free disk space in byte. (-1 when error occurs)
@property (nonatomic, readonly, getter=lf_diskSpaceFree) int64_t diskSpaceFree;

/// Used disk space in byte. (-1 when error occurs)
@property (nonatomic, readonly, getter=lf_diskSpaceUsed) int64_t diskSpaceUsed;


#pragma mark - Memory Information
///=============================================================================
/// @name Memory Information
///=============================================================================

/// Total physical memory in byte. (-1 when error occurs)
@property (nonatomic, readonly, getter=lf_memoryTotal) int64_t memoryTotal;

/// Used (active + inactive + wired) memory in byte. (-1 when error occurs)
@property (nonatomic, readonly, getter=lf_memoryUsed) int64_t memoryUsed;

/// Free memory in byte. (-1 when error occurs)
@property (nonatomic, readonly, getter=lf_memoryFree) int64_t memoryFree;

/// Acvite memory in byte. (-1 when error occurs)
@property (nonatomic, readonly, getter=lf_memoryActive) int64_t memoryActive;

/// Inactive memory in byte. (-1 when error occurs)
@property (nonatomic, readonly, getter=lf_memoryInactive) int64_t memoryInactive;

/// Wired memory in byte. (-1 when error occurs)
@property (nonatomic, readonly, getter=lf_memoryWired) int64_t memoryWired;

/// Purgable memory in byte. (-1 when error occurs)
@property (nonatomic, readonly, getter=lf_memoryPurgable) int64_t memoryPurgable;

@property (nonatomic,copy ,readonly, getter=lf_CPUType) NSString *CPUType;
@property (nonatomic,copy ,readonly, getter=lf_CPUSubtype) NSString *CPUSubtype;


#pragma mark - System version compare
///=============================================================================
/// @name System version compare
///=============================================================================

- (BOOL)lf_systemVersionLowerThan:(NSString*)version;
- (BOOL)lf_systemVersionNotHigherThan:(NSString *)version;
- (BOOL)lf_systemVersionHigherThan:(NSString*)version;
- (BOOL)lf_systemVersionNotLowerThan:(NSString *)version;

#pragma mark - Others
///=============================================================================
/// @name Others
///=============================================================================

/// 设备是否越狱
/// Whether the device is jailbroken.
@property (nonatomic, readonly, getter=lf_isJailbroken) BOOL isJailbroken;

//
+ (void)lf_cameraAuthorzied:(cameraAuthorziedBlock)authorizedBlock notAuthorized:(cameraAuthorziedBlock)notAuthorizedlock;
-(NSString*)lf_deviceID;

@end
