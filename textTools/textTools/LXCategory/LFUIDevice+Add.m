//
//  UIDevice+Add.m
//
//
//  Created by guoyaoyuan on 13-4-3.
//  Copyright (c) 2013 live Interactive. All rights reserved.
//

#import "LFUIDevice+Add.h"
#include <sys/sysctl.h>
#include <mach/mach.h>
#import "LFCategoryMacro.h"
#import "LFNSString+Add.h"
#import <AVFoundation/AVFoundation.h>


@implementation UIDevice (LFAdditions)

- (BOOL)lf_isPad {
    static dispatch_once_t one;
    static BOOL pad;
    dispatch_once(&one, ^{
        pad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
    });
    return pad;
}

- (BOOL)lf_isSimulator {
    static dispatch_once_t one;
    static BOOL simu;
    dispatch_once(&one, ^{
        simu = NSNotFound != [[self model] rangeOfString:@"Simulator"].location;
    });
    return simu;
}

//- (BOOL)isJailbroken {
//    if ([self isSimulator]) return NO; // Dont't check simulator
//
//    NSURL *cydiaURL = [NSURL URLWithString:@"cydia://package/com.saurik.cydia"];
//    if ([[UIApplication sharedApplication] canOpenURL:cydiaURL]) return YES;
//
//    NSArray *paths = @[@"/Applications/Cydia.app",
//                       @"/private/var/lib/apt/",
//                       @"/private/var/lib/cydia",
//                       @"/private/var/stash"];
//    for (NSString *path in paths) {
//        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) return YES;
//    }
//
//    FILE *bash = fopen("/bin/bash", "r");
//    if (bash != NULL) {
//        fclose(bash);
//        return YES;
//    }
//
//    NSString *path = [NSString stringWithFormat:@"/private/%@", [NSString stringWithUUID]];
//    if ([@"test" writeToFile : path atomically : YES encoding : NSUTF8StringEncoding error : NULL]) {
//        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
//        return YES;
//    }
//
//    return NO;
//}

- (BOOL)lf_canMakePhoneCalls {
    __block BOOL can;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        can = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]];
    });
    return can;
}

- (NSString *)lf_machineModel {
    static dispatch_once_t one;
    static NSString *model;
    dispatch_once(&one, ^{
        size_t size;
        sysctlbyname("hw.machine", NULL, &size, NULL, 0);
        char *machine = malloc(size);
        sysctlbyname("hw.machine", machine, &size, NULL, 0);
        model = [NSString stringWithUTF8String:machine];
        free(machine);
    });
    return model;
}

- (NSString *)lf_machineModelName {
    static dispatch_once_t one;
    static NSString *name;
    dispatch_once(&one, ^{
        NSString *model = [self lf_machineModel];
        if ([model isEqualToString:@"iPhone1,1"]) name = @"iPhone 1G";
        else if ([model isEqualToString:@"iPhone1,2"]) name = @"iPhone 3G";
        else if ([model isEqualToString:@"iPhone2,1"]) name = @"iPhone 3GS";
        else if ([model isEqualToString:@"iPhone3,1"]) name = @"iPhone 4 (GSM)";
        else if ([model isEqualToString:@"iPhone3,2"]) name = @"iPhone 4";
        else if ([model isEqualToString:@"iPhone3,3"]) name = @"iPhone 4 (CDMA)";
        else if ([model isEqualToString:@"iPhone4,1"]) name = @"iPhone 4S";
        else if ([model isEqualToString:@"iPhone5,1"]) name = @"iPhone 5";
        else if ([model isEqualToString:@"iPhone5,2"]) name = @"iPhone 5";
        else if ([model isEqualToString:@"iPhone5,3"]) name = @"iPhone 5c";
        else if ([model isEqualToString:@"iPhone5,4"]) name = @"iPhone 5c";
        else if ([model isEqualToString:@"iPhone6,1"]) name = @"iPhone 5s";
        else if ([model isEqualToString:@"iPhone6,2"]) name = @"iPhone 5s";
        else if ([model isEqualToString:@"iPhone7,1"]) name = @"iPhone 6 Plus";
        else if ([model isEqualToString:@"iPhone7,2"]) name = @"iPhone 6";
        
        else if ([model isEqualToString:@"iPod1,1"]) name = @"iPod 1";
        else if ([model isEqualToString:@"iPod2,1"]) name = @"iPod 2";
        else if ([model isEqualToString:@"iPod3,1"]) name = @"iPod 3";
        else if ([model isEqualToString:@"iPod4,1"]) name = @"iPod 4";
        else if ([model isEqualToString:@"iPod5,1"]) name = @"iPod 5";
        
        else if ([model isEqualToString:@"iPad1,1"]) name = @"iPad 1";
        else if ([model isEqualToString:@"iPad2,1"]) name = @"iPad 2 (WiFi)";
        else if ([model isEqualToString:@"iPad2,2"]) name = @"iPad 2 (GSM)";
        else if ([model isEqualToString:@"iPad2,3"]) name = @"iPad 2 (CDMA)";
        else if ([model isEqualToString:@"iPad2,4"]) name = @"iPad 2";
        else if ([model isEqualToString:@"iPad2,5"]) name = @"iPad mini 1";
        else if ([model isEqualToString:@"iPad2,6"]) name = @"iPad mini 1";
        else if ([model isEqualToString:@"iPad2,7"]) name = @"iPad mini 1";
        else if ([model isEqualToString:@"iPad3,1"]) name = @"iPad 3 (WiFi)";
        else if ([model isEqualToString:@"iPad3,2"]) name = @"iPad 3 (4G)";
        else if ([model isEqualToString:@"iPad3,3"]) name = @"iPad 3 (4G)";
        else if ([model isEqualToString:@"iPad3,4"]) name = @"iPad 4";
        else if ([model isEqualToString:@"iPad3,5"]) name = @"iPad 4";
        else if ([model isEqualToString:@"iPad3,6"]) name = @"iPad 4";
        else if ([model isEqualToString:@"iPad4,1"]) name = @"iPad Air";
        else if ([model isEqualToString:@"iPad4,2"]) name = @"iPad Air";
        else if ([model isEqualToString:@"iPad4,3"]) name = @"iPad Air";
        else if ([model isEqualToString:@"iPad4,4"]) name = @"iPad mini 2";
        else if ([model isEqualToString:@"iPad4,5"]) name = @"iPad mini 2";
        else if ([model isEqualToString:@"iPad4,6"]) name = @"iPad mini 2";
        else if ([model isEqualToString:@"iPad4,7"]) name = @"iPad mini 3";
        else if ([model isEqualToString:@"iPad4,8"]) name = @"iPad mini 3";
        else if ([model isEqualToString:@"iPad4,9"]) name = @"iPad mini 3";
        else if ([model isEqualToString:@"iPad5,3"]) name = @"iPad Air 2";
        else if ([model isEqualToString:@"iPad5,4"]) name = @"iPad Air 2";
        
        else if ([model isEqualToString:@"i386"]) name = @"Simulator x86";
        else if ([model isEqualToString:@"x86_64"]) name = @"Simulator x64";
        else name = model;
    });
    return name;
}

+ (CGSize)lf_screenSize {
    static CGSize size;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        size = [UIScreen mainScreen].bounds.size;
        if (size.height <= size.width) {
            CGFloat tmp = size.height;
            size.height = size.width;
            size.width = tmp;
        }
    });
    return size;
}

- (CGFloat)lf_systemVersionByFloat {
    return [self.systemVersion floatValue];
}

+ (CGFloat)lf_systemVersionByFloat {
    static CGFloat v;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        v = [[UIDevice currentDevice].systemVersion floatValue];
    });
    return v;
}

- (int64_t)lf_diskSpace {
    NSError *error = nil;
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) return -1;
    int64_t space =  [[attrs objectForKey:NSFileSystemSize] longLongValue];
    if (space < 0) space = -1;
    return space;
}

- (int64_t)lf_diskSpaceFree {
    NSError *error = nil;
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) return -1;
    int64_t space =  [[attrs objectForKey:NSFileSystemFreeSize] longLongValue];
    if (space < 0) space = -1;
    return space;
}

- (int64_t)lf_diskSpaceUsed {
    int64_t total = self.lf_diskSpace;
    int64_t free = self.lf_diskSpaceFree;
    if (total < 0 || free < 0) return -1;
    int64_t used = total - free;
    if (used < 0) used = -1;
    return used;
}

- (int64_t)lf_memoryTotal {
    int64_t mem = [[NSProcessInfo processInfo] physicalMemory];
    if (mem < -1) mem = -1;
    return mem;
}

- (int64_t)lf_memoryUsed {
    vm_statistics_data_t vm;
    mach_msg_type_number_t size = HOST_VM_INFO_COUNT;
    kern_return_t kern = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vm, &size);
    if (kern != KERN_SUCCESS) return -1;
    int64_t mem = vm_page_size * (vm.active_count +
                                  vm.inactive_count +
                                  vm.wire_count);
    if (mem < 0) mem = -1;
    return mem;
}

- (int64_t)lf_memoryFree {
    vm_statistics_data_t vm;
    mach_msg_type_number_t size = HOST_VM_INFO_COUNT;
    kern_return_t kern = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vm, &size);
    if (kern != KERN_SUCCESS) return -1;
    int64_t mem = vm_page_size * vm.free_count;
    if (mem < 0) mem = -1;
    return mem;
}

- (int64_t)lf_memoryActive {
    vm_statistics_data_t vm;
    mach_msg_type_number_t size = HOST_VM_INFO_COUNT;
    kern_return_t kern = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vm, &size);
    if (kern != KERN_SUCCESS) return -1;
    int64_t mem = vm_page_size * vm.active_count;
    if (mem < 0) mem = -1;
    return mem;
}

- (int64_t)lf_memoryInactive {
    vm_statistics_data_t vm;
    mach_msg_type_number_t size = HOST_VM_INFO_COUNT;
    kern_return_t kern = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vm, &size);
    if (kern != KERN_SUCCESS) return -1;
    int64_t mem = vm_page_size * vm.inactive_count;
    if (mem < 0) mem = -1;
    return mem;
}

- (int64_t)lf_memoryWired {
    vm_statistics_data_t vm;
    mach_msg_type_number_t size = HOST_VM_INFO_COUNT;
    kern_return_t kern = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vm, &size);
    if (kern != KERN_SUCCESS) return -1;
    int64_t mem = vm_page_size * vm.wire_count;
    if (mem < 0) mem = -1;
    return mem;
}

- (int64_t)lf_memoryPurgable {
    vm_statistics_data_t vm;
    mach_msg_type_number_t size = HOST_VM_INFO_COUNT;
    kern_return_t kern = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vm, &size);
    if (kern != KERN_SUCCESS) return -1;
    int64_t mem = vm_page_size * vm.purgeable_count;
    if (mem < 0) mem = -1;
    return mem;
}

- (NSString*)lf_CPUType{
    host_basic_info_data_t hostInfo;
    mach_msg_type_number_t infoCount;
    
    infoCount = HOST_BASIC_INFO_COUNT;
    host_info(mach_host_self(), HOST_BASIC_INFO,
              (host_info_t)&hostInfo, &infoCount);
    
    cpu_type_t CPUType = hostInfo.cpu_type;
    
    if ((CPUType & (~CPU_ARCH_MASK)) == CPU_TYPE_ARM)
    {
        return [NSString stringWithFormat: @"ARM(%d bit)", (CPUType & CPU_ARCH_ABI64) ? 64 : 32];
    }
    else if ((CPUType & (~CPU_ARCH_MASK)) == CPU_TYPE_X86)
    {
        return @"X86(64 bit)";
    }
    else
    {
        return nil;
    }
}

- (NSString *)lf_CPUSubtype
{
    host_basic_info_data_t hostInfo;
    mach_msg_type_number_t infoCount;
    
    infoCount = HOST_BASIC_INFO_COUNT;
    host_info(mach_host_self(), HOST_BASIC_INFO,
              (host_info_t)&hostInfo, &infoCount);
    
    cpu_type_t CPUType = hostInfo.cpu_type;
    cpu_subtype_t CPUSubtype = hostInfo.cpu_subtype;
    
    if ((CPUType & (~CPU_ARCH_MASK)) == CPU_TYPE_ARM)
    {
        
        switch (CPUSubtype)
        {
                
            case CPU_SUBTYPE_ARM_V6:
            {
                return @"armv6";
            }
                
            case CPU_SUBTYPE_ARM_V7:
            {
                return @"armv7";
            }
                
            case CPU_SUBTYPE_ARM_V7S:
            {
                return @"armv7s";
            }
                
            default:
            {
                return nil;
            }
                
        }
        
    }
    else if ((CPUType & (~CPU_ARCH_MASK)) == CPU_TYPE_X86)
    {
        return @"x86_64";
    }
    else
    {
        return nil;
    }
    
}

- (BOOL)lf_systemVersionLowerThan:(NSString *)version {
    if (version == nil || version.length == 0) {
        return NO;
    }
    
    if ([self.systemVersion compare:version options:NSNumericSearch] == NSOrderedAscending) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)lf_systemVersionHigherThan:(NSString *)version {
    if (version == nil || version.length == 0) {
        return NO;
    }
    
    if ([self.systemVersion compare:version options:NSNumericSearch] == NSOrderedDescending) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)lf_systemVersionNotHigherThan:(NSString *)version {
    if (version == nil || version.length == 0) {
        return NO;
    }
    
    if ([self.systemVersion isEqualToString:version]) {
        return YES;
    } else {
        return [self lf_systemVersionLowerThan:version];
    }
}

- (BOOL)lf_systemVersionNotLowerThan:(NSString *)version {
    if (version == nil || version.length == 0) {
        NSLog(@"### Error Version");
        return NO;
    }
    
    if ([self.systemVersion isEqualToString:version]) {
        return YES;
    } else {
        return [self lf_systemVersionHigherThan:version];
    }
}

- (BOOL)lf_isJailbroken {
    if ([self lf_isSimulator]) return NO; // Dont't check simulator
    
    NSURL *cydiaURL = [NSURL URLWithString:@"cydia://package/com.saurik.cydia"];
    if ([[UIApplication sharedApplication] canOpenURL:cydiaURL]) return YES;
    
    NSArray *paths = @[@"/Applications/Cydia.app",
                       @"/private/var/lib/apt/",
                       @"/private/var/lib/cydia",
                       @"/private/var/stash"];
    for (NSString *path in paths) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) return YES;
    }
    
    FILE *bash = fopen("/bin/bash", "r");
    if (bash != NULL) {
        fclose(bash);
        return YES;
    }
    
    NSString *path = [NSString stringWithFormat:@"/private/%@", [NSString lf_stringWithUUID]];
    if ([@"test" writeToFile : path atomically : YES encoding : NSUTF8StringEncoding error : NULL]) {
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        return YES;
    }
    
    return NO;
}

+ (void)lf_cameraAuthorzied:(cameraAuthorziedBlock)authorizedBlock notAuthorized:(cameraAuthorziedBlock)notAuthorizedlock
{
    if([UIDevice isHigherIOS7]) {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    if (authorizedBlock) {
                        authorizedBlock();
                    }
                }else{
                    if (notAuthorizedlock) {
                        notAuthorizedlock();
                    }
                }
            }];
        }else if (authStatus == AVAuthorizationStatusAuthorized){
            if (authorizedBlock) {
                authorizedBlock();
            }
        }else{
            if (notAuthorizedlock) {
                notAuthorizedlock();
            }
        }
    }else{
        if (authorizedBlock) {
            authorizedBlock();
        }
    }
}




/*
 下面的那坨pragma只是为了去除编译警告..
 参考: http://fuckingclangwarnings.com
 */
-(NSString*)lf_deviceID {
    Class cls = NSClassFromString(@"UMANUtil");
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    SEL deviceIDSelector = @selector(openUDIDString);
#pragma clang diagnostic pop
    
    NSString *deviceID = nil;
    if(cls && [cls respondsToSelector:deviceIDSelector]){
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        deviceID = [cls performSelector:deviceIDSelector];
#pragma clang diagnostic pop
    }
    if (!deviceID) return nil;

    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:@{@"oid" : deviceID}
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    
    NSLog(@"%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
    return deviceID;
}

+ (BOOL)isHigherIOS7
{
    NSString * requestSysVer = @"7.0";
    NSString *currentSysVer = [[UIDevice currentDevice] systemVersion];
    if ([currentSysVer compare:requestSysVer options:NSNumericSearch] != NSOrderedAscending) {
        
        return YES;
    }
    
    return NO;
}

@end
