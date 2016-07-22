//
//Macro.h
//
//  Created by guoyaoyuan on 13-3-29.
//  Copyright (c) 2013 live Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sys/time.h>
#import <pthread.h>

#ifndef LFCategoryMacro_h
#define LFCategoryMacro_h

#ifdef __cplusplus
#define LF_EXTERN_C_BEGIN  extern "C" {
#define LF_EXTERN_C_END  }
#else
#define LF_EXTERN_C_BEGIN
#define LF_EXTERN_C_END
#endif


LF_EXTERN_C_BEGIN


/**
 动态给一个类添加 property (.h)
 Synthsize a dynamic object property in @implementation scope.
 It allows us to add custom properties to existing classes in categories.
 
 @param association  ASSIGN / RETAIN / COPY / RETAIN_NONATOMIC / COPY_NONATOMIC
 @warning #import <objc/runtime.h>
 *******************************************************************************
 Example:
     @interface NSObject (MyAdd)
     @property (nonatomic, retain) UIColor *myColor;
     @end
     
     #import <objc/runtime.h>
     @implementation NSObject (MyAdd)
        SYNTH_DYNAMIC_PROPERTY_OBJ(myColor, setMyColor, RETAIN, UIColor *)
     @end
 */
#ifndef SYNTH_DYNAMIC_PROPERTY_OBJ
#define SYNTH_DYNAMIC_PROPERTY_OBJ(getter, setter, association, type) \
- (void)setter : (type)object { \
    objc_setAssociatedObject(self, _cmd, object, OBJC_ASSOCIATION_ ## association); \
} \
- (type)getter { \
    return objc_getAssociatedObject(self, @selector(setter:)); \
}
#endif


/**
 动态给一个类添加 property (.m)
 Synthsize a dynamic c type property in @implementation scope.
 It allows us to add custom properties to existing classes in categories.
 
 @warning #import <objc/runtime.h>
 *******************************************************************************
 Example:
     @interface NSObject (MyAdd)
     @property (nonatomic, retain) CGPoint myPoint;
     @end
     
     #import <objc/runtime.h>
     @implementation NSObject (MyAdd)
        SYNTH_DYNAMIC_PROPERTY_CTYPE(myPoint, setMyPoint, CGPoint)
     @end
 */
#ifndef SYNTH_DYNAMIC_PROPERTY_CTYPE
#define SYNTH_DYNAMIC_PROPERTY_CTYPE(getter, setter, type) \
- (void)setter : (type)object { \
    NSValue *value = [NSValue value:&object withObjCType:@encode(type)]; \
    objc_setAssociatedObject(self, _cmd, value, OBJC_ASSOCIATION_RETAIN); \
} \
- (type)getter { \
    type cValue = { 0 }; \
    NSValue *value = objc_getAssociatedObject(self, @selector(setter:)); \
    [value getValue:&cValue]; \
    return cValue; \
}
#endif


/**
 合成一个单例
 Synthesize a sharedInstace.
 *******************************************************************************
 Example:
     - (MyManager *)sharedManager {
         SYNTH_SHARED_INSTANCE();
     }
 */
#ifndef SYNTH_SHARED_INSTANCE
#define SYNTH_SHARED_INSTANCE() \
    static id sharedInstance = nil; \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        sharedInstance  = [[[self class] alloc] init]; \
    }); \
    return sharedInstance;
#endif





/**
 Synthsize a weak or strong reference.
 
 Example:
    @weakify(self)
    [self doSomething^{
        @strongify(self)
        self.xxx
        ...
    }];

 */
#ifndef weakify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif

#ifndef strongify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object; if (!object) return;
        #else
        #define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object; if (!object) return;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object; if (!object) return;
        #else
        #define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object; if (!object) return;
        #endif
    #endif
#endif





/**
 A macro that converts a number from degress to radians.
 */
#ifndef DEGREES_TO_RADIANS
#define DEGREES_TO_RADIANS(d) ((d) * M_PI / 180.0)
#endif

/**
 A macro that converts a number from radians to degrees.
 */
#ifndef RADIANS_TO_DEGREES
#define RADIANS_TO_DEGREES(r) ((d) * 180.0 / M_PI)
#endif

/// 屏幕宽度
#ifndef kScreenWidth
#define kScreenWidth [UIDevice lf_screenSize].width
#endif

/// 屏幕高度
#ifndef kScreenHeight
#define kScreenHeight [UIDevice lf_screenSize].height
#endif

/// 屏幕大小
#ifndef kScreenSize
#define kScreenSize [UIDevice lf_screenSize]
#endif

/// 屏幕Scale
#ifndef kScreenScale
#define kScreenScale [UIScreen mainScreen].scale
#endif

/// 系统版本 (float)
#ifndef kSystemVersion
#define kSystemVersion [UIDevice lf_systemVersionByFloat]
#endif

#ifndef kiOS6Later
#define kiOS6Later ([UIDevice lf_systemVersionByFloat] >= 6)
#endif

#ifndef kiOS7Later
#define kiOS7Later ([UIDevice lf_systemVersionByFloat] >= 7)
#endif

#ifndef kiOS8Later
#define kiOS8Later ([UIDevice lf_systemVersionByFloat] >= 8)
#endif

#ifndef kSuperImageRatio
#define kSuperImageRatio 2.9
#endif

#ifndef _UTKDevLog
#ifdef DEBUG
#define _UTKDevLog(...) NSLog(__VA_ARGS__)
#else
#define _UTKDevLog(...) do { } while (0)
#endif
#endif //_UTKDevLog


#ifndef LF_MAX
#define LF_MAX(a, b)  (((a) > (b)) ? (a) : (b))
#endif

#ifndef LF_MIN
#define LF_MIN(a, b)  (((a) < (b)) ? (a) : (b))
#endif

#ifndef LF_ABS
#define LF_ABS(a)  (((a) < 0) ? -(a) : (a))
#endif

#ifndef LF_CLAMP
#define LF_CLAMP(x, low, high)  (((x) > (high)) ? (high) : (((x) < (low)) ? (low) : (x)))
#endif

#ifndef LF_SWAP
#define LF_SWAP(a, b)  do { __typeof__(a) _tmp_ = (a); (a) = (b); (b) = _tmp_; } while (0)
#endif

#ifndef LaiFeng_AppMarco_h
#define MAX_IMAGE_SIZE 720
#define kSuperRatioMaxLength 1600
#endif

/**
 测试方法调用时间
 
 @param ^block     code to profile
 @param ^complete  code time cost (ms)
 */
static inline void ProfileTime(void (^block)(void), void (^complete)(double ms)) {
    struct timeval t0, t1;
    gettimeofday(&t0, NULL);
    block();
    gettimeofday(&t1, NULL);
    double ms = (double)(t1.tv_sec - t0.tv_sec) * 1e3 + (double)(t1.tv_usec - t0.tv_usec) * 1e-3;
    complete(ms);
}

/**
 same as NSMakeRange()
 */
static inline NSRange NSRangeMake(NSUInteger location, NSUInteger length) {
    NSRange r;
    r.location = location;
    r.length = length;
    return r;
}

/**
 Ceil the rect (for string drawing calculate)
 */
static inline CGRect CGRectCeil(CGRect rect) {
    return CGRectMake(ceil(rect.origin.x), ceil(rect.origin.y), ceil(rect.size.width), ceil(rect.size.height));
}

/**
 Ceil the size (for string drawing calculate)
 */
static inline CGSize CGSizeCeil(CGSize size) {
    return CGSizeMake(ceil(size.width), ceil(size.height));
}

/**
 The Center of this rect.
 */
static inline CGPoint CGRectCenter(CGRect rect) {
    return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

static inline CGFloat DegreesToRadians(CGFloat degrees) {
    return degrees * M_PI / 180;
}

static inline CGFloat RadiansToDegrees(CGFloat radians) {
    return radians * 180 / M_PI;
}

static inline uint64_t CurrentTimeMillis() {
    return (uint64_t)([[NSDate date] timeIntervalSince1970] * 1000);
}

/**
 Returns a dispatch_time delay from now.
 */
static inline dispatch_time_t dispatch_time_delay(NSTimeInterval second) {
    return dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC));
}

/**
 Returns a dispatch_wall_time delay from now.
 */
static inline dispatch_time_t dispatch_walltime_delay(NSTimeInterval second) {
    return dispatch_walltime(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC));
}

/**
 Returns a dispatch_wall_time from NSDate.
 */
static inline dispatch_time_t dispatch_walltime_date(NSDate *date) {
    NSTimeInterval interval;
    double second, subsecond;
    struct timespec time;
    dispatch_time_t milestone;
    
    interval = [date timeIntervalSince1970];
    subsecond = modf(interval, &second);
    time.tv_sec = second;
    time.tv_nsec = subsecond * NSEC_PER_SEC;
    milestone = dispatch_walltime(&time, 0);
    return milestone;
}

static inline bool dispatch_is_main_queue() {
    // pthread_main_np(void);
    return [NSThread isMainThread];
}


/**
 Submits a block for asynchronous execution on a main queue and returns immediately.
 */
static inline void dispatch_async_on_main_queue(void (^block)()) {
    if (pthread_main_np()) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

/**
 Submits a block for execution on a main queue and waits until the block completes.
 */
static inline void dispatch_sync_on_main_queue(void (^block)()) {
    if (pthread_main_np()) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}
LF_EXTERN_C_END
#endif
