//
//  LFClassInfo.h
//  YYKit <https://github.com/ibireme/YYKit>
//
//  Created by guoyaoyuan on 15/5/9.
//  Copyright (c) 2015 guoyaoyuan.
//
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

/**
 Type encoding's type.
 */
typedef NS_OPTIONS(NSUInteger, LFEncodingType) {
    LFEncodingTypeMask       = 0xFF, ///< mask of type value
    LFEncodingTypeUnknown    = 0, ///< unknown
    LFEncodingTypeVoid       = 1, ///< void
    LFEncodingTypeBool       = 2, ///< bool
    LFEncodingTypeInt8       = 3, ///< char / BOOL
    LFEncodingTypeUInt8      = 4, ///< unsigned char
    LFEncodingTypeInt16      = 5, ///< short
    LFEncodingTypeUInt16     = 6, ///< unsigned short
    LFEncodingTypeInt32      = 7, ///< int
    LFEncodingTypeUInt32     = 8, ///< unsigned int
    LFEncodingTypeInt64      = 9, ///< long long
    LFEncodingTypeUInt64     = 10, ///< unsigned long long
    LFEncodingTypeFloat      = 11, ///< float
    LFEncodingTypeDouble     = 12, ///< double
    LFEncodingTypeLongDouble = 13, ///< long double
    LFEncodingTypeObject     = 14, ///< id
    LFEncodingTypeClass      = 15, ///< Class
    LFEncodingTypeSEL        = 16, ///< SEL
    LFEncodingTypeBlock      = 17, ///< block
    LFEncodingTypePointer    = 18, ///< void*
    LFEncodingTypeStruct     = 19, ///< struct
    LFEncodingTypeUnion      = 20, ///< union
    LFEncodingTypeCString    = 21, ///< char*
    LFEncodingTypeCArray     = 22, ///< char[10] (for example)
    
    LFEncodingTypeQualifierMask   = 0xFF00,   ///< mask of qualifier
    LFEncodingTypeQualifierConst  = 1 << 8,  ///< const
    LFEncodingTypeQualifierIn     = 1 << 9,  ///< in
    LFEncodingTypeQualifierInout  = 1 << 10, ///< inout
    LFEncodingTypeQualifierOut    = 1 << 11, ///< out
    LFEncodingTypeQualifierBycopy = 1 << 12, ///< bycopy
    LFEncodingTypeQualifierByref  = 1 << 13, ///< byref
    LFEncodingTypeQualifierOneway = 1 << 14, ///< oneway
    
    LFEncodingTypePropertyMask         = 0xFF0000, ///< mask of property
    LFEncodingTypePropertyReadonly     = 1 << 16, ///< readonly
    LFEncodingTypePropertyCopy         = 1 << 17, ///< copy
    LFEncodingTypePropertyRetain       = 1 << 18, ///< retain
    LFEncodingTypePropertyNonatomic    = 1 << 19, ///< nonatomic
    LFEncodingTypePropertyWeak         = 1 << 20, ///< weak
    LFEncodingTypePropertyCustomGetter = 1 << 21, ///< getter=
    LFEncodingTypePropertyCustomSetter = 1 << 22, ///< setter=
    LFEncodingTypePropertyDynamic      = 1 << 23, ///< @dynamic
};

/**
 Get the type from a Type-Encoding string.
 
 @discussion See also:
 https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
 https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtPropertyIntrospection.html
 
 @param typeEncoding  A Type-Encoding string.
 @return The encoding type.
 */
LFEncodingType LFEncodingGetType(const char *typeEncoding);


/**
 Instance variable information.
 */
@interface LFClassIvarInfo : NSObject
@property (nonatomic, assign, readonly) Ivar ivar;
@property (nonatomic, strong, readonly) NSString *name; ///< Ivar's name
@property (nonatomic, assign, readonly) ptrdiff_t offset; ///< Ivar's offset
@property (nonatomic, strong, readonly) NSString *typeEncoding; ///< Ivar's type encoding
@property (nonatomic, assign, readonly) LFEncodingType type; ///< Ivar's type
- (instancetype)initWithIvar:(Ivar)ivar;
@end

/**
 Method information.
 */
@interface LFClassMethodInfo : NSObject
@property (nonatomic, assign, readonly) Method method;
@property (nonatomic, strong, readonly) NSString *name; ///< method name
@property (nonatomic, assign, readonly) SEL sel; ///< method's selector
@property (nonatomic, assign, readonly) IMP imp; ///< method's implementation
@property (nonatomic, strong, readonly) NSString *typeEncoding; ///< method's parameter and return types
@property (nonatomic, strong, readonly) NSString *returnTypeEncoding; ///< return value's type
@property (nonatomic, strong, readonly) NSArray *argumentTypeEncodings; ///< array of arguments' type
- (instancetype)initWithMethod:(Method)method;
@end

/**
 Property information.
 */
@interface LFClassPropertyInfo : NSObject
@property (nonatomic, assign, readonly) objc_property_t property;
@property (nonatomic, strong, readonly) NSString *name; ///< property's name
@property (nonatomic, assign, readonly) LFEncodingType type; ///< property's type
@property (nonatomic, strong, readonly) NSString *typeEncoding; ///< property's encoding value
@property (nonatomic, strong, readonly) NSString *ivarName; ///< property's ivar name
@property (nonatomic, assign, readonly) Class cls; ///< may be nil
@property (nonatomic, strong, readonly) NSString *getter; ///< getter (nonnull)
@property (nonatomic, strong, readonly) NSString *setter; ///< setter (nonnull)
- (instancetype)initWithProperty:(objc_property_t)property;
@end

/**
 Class information for a class.
 */
@interface LFClassInfo : NSObject

@property (nonatomic, assign, readonly) Class cls;
@property (nonatomic, assign, readonly) Class superCls;
@property (nonatomic, assign, readonly) Class metaCls;
@property (nonatomic, assign, readonly) BOOL isMeta;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) LFClassInfo *superClassInfo;

@property (nonatomic, strong, readonly) NSDictionary *ivarInfos;     ///< key:NSString(ivar),     value:LFClassIvarInfo
@property (nonatomic, strong, readonly) NSDictionary *methodInfos;   ///< key:NSString(selector), value:LFClassMethodInfo
@property (nonatomic, strong, readonly) NSDictionary *propertyInfos; ///< key:NSString(property), value:LFClassPropertyInfo

/**
 If the class is changed (for example: you add a method to this class with
 'class_addMethod()'), you should call this method to refresh the class info cache.
 
 After called this method, you may call 'classInfoWithClass' or 
 'classInfoWithClassName' to get the updated class info.
 */
- (void)setNeedUpdate;

/**
 Get the class info of a specified Class.
 
 @discussion This method will cache the class info and super-class info
 at the first access to the Class. This method is thread-safe.
 
 @param cls A class.
 @return A class info, or nil if an error occurs.
 */
+ (instancetype)lf_classInfoWithClass:(Class)cls;

/**
 Get the class info of a specified Class.
 
 @discussion This method will cache the class info and super-class info
 at the first access to the Class. This method is thread-safe.
 
 @param className A class name.
 @return A class info, or nil if an error occurs.
 */
+ (instancetype)lf_classInfoWithClassName:(NSString *)className;

@end
