//
//  LFClassInfo.m
//  YYKit <https://github.com/ibireme/YYKit>
//
//  Created by guoyaoyuan on 15/5/9.
//  Copyright (c) 2015 guoyaoyuan.
//
//

#import "LFClassInfo.h"
#import <objc/runtime.h>

LFEncodingType LFEncodingGetType(const char *typeEncoding) {
    char *type = (char *)typeEncoding;
    if (!type) return LFEncodingTypeUnknown;
    size_t len = strlen(type);
    if (len == 0) return LFEncodingTypeUnknown;
    
    LFEncodingType qualifier = 0;
    bool prefix = true;
    while (prefix) {
        switch (*type) {
            case 'r': {
                qualifier |= LFEncodingTypeQualifierConst;
                type++;
            } break;
            case 'n': {
                qualifier |= LFEncodingTypeQualifierIn;
                type++;
            } break;
            case 'N': {
                qualifier |= LFEncodingTypeQualifierInout;
                type++;
            } break;
            case 'o': {
                qualifier |= LFEncodingTypeQualifierOut;
                type++;
            } break;
            case 'O': {
                qualifier |= LFEncodingTypeQualifierBycopy;
                type++;
            } break;
            case 'R': {
                qualifier |= LFEncodingTypeQualifierByref;
                type++;
            } break;
            case 'V': {
                qualifier |= LFEncodingTypeQualifierOneway;
                type++;
            } break;
            default: { prefix = false; } break;
        }
    }

    len = strlen(type);
    if (len == 0) return LFEncodingTypeUnknown | qualifier;

    switch (*type) {
        case 'v': return LFEncodingTypeVoid | qualifier;
        case 'B': return LFEncodingTypeBool | qualifier;
        case 'c': return LFEncodingTypeInt8 | qualifier;
        case 'C': return LFEncodingTypeUInt8 | qualifier;
        case 's': return LFEncodingTypeInt16 | qualifier;
        case 'S': return LFEncodingTypeUInt16 | qualifier;
        case 'i': return LFEncodingTypeInt32 | qualifier;
        case 'I': return LFEncodingTypeUInt32 | qualifier;
        case 'l': return LFEncodingTypeInt32 | qualifier;
        case 'L': return LFEncodingTypeUInt32 | qualifier;
        case 'q': return LFEncodingTypeInt64 | qualifier;
        case 'Q': return LFEncodingTypeUInt64 | qualifier;
        case 'f': return LFEncodingTypeFloat | qualifier;
        case 'd': return LFEncodingTypeDouble | qualifier;
        case 'D': return LFEncodingTypeLongDouble | qualifier;
        case '#': return LFEncodingTypeClass | qualifier;
        case ':': return LFEncodingTypeSEL | qualifier;
        case '*': return LFEncodingTypeCString | qualifier;
        case '^': return LFEncodingTypePointer | qualifier;
        case '[': return LFEncodingTypeCArray | qualifier;
        case '(': return LFEncodingTypeUnion | qualifier;
        case '{': return LFEncodingTypeStruct | qualifier;
        case '@': {
            if (len == 2 && *(type + 1) == '?')
                return LFEncodingTypeBlock | qualifier;
            else
                return LFEncodingTypeObject | qualifier;
        }
        default: return LFEncodingTypeUnknown | qualifier;
    }
}

@implementation LFClassIvarInfo

- (instancetype)initWithIvar:(Ivar)ivar {
    if (!ivar) return nil;
    self = [super init];
    _ivar = ivar;
    const char *name = ivar_getName(ivar);
    if (name) {
        _name = [NSString stringWithUTF8String:name];
    }
    _offset = ivar_getOffset(ivar);
    const char *typeEncoding = ivar_getTypeEncoding(ivar);
    if (typeEncoding) {
        _typeEncoding = [NSString stringWithUTF8String:typeEncoding];
        _type = LFEncodingGetType(typeEncoding);
    }
    return self;
}

@end

@implementation LFClassMethodInfo

- (instancetype)initWithMethod:(Method)method {
    if (!method) return nil;
    self = [super init];
    _method = method;
    _sel = method_getName(method);
    _imp = method_getImplementation(method);
    const char *name = sel_getName(_sel);
    if (name) {
        _name = [NSString stringWithUTF8String:name];
    }
    const char *typeEncoding = method_getTypeEncoding(method);
    if (typeEncoding) {
        _typeEncoding = [NSString stringWithUTF8String:typeEncoding];
    }
    char *returnType = method_copyReturnType(method);
    if (returnType) {
        _returnTypeEncoding = [NSString stringWithUTF8String:returnType];
        free(returnType);
    }
    unsigned int argumentCount = method_getNumberOfArguments(method);
    if (argumentCount > 0) {
        NSMutableArray *argumentTypes = [NSMutableArray new];
        for (unsigned int i = 0; i < argumentCount; i++) {
            char *argumentType = method_copyArgumentType(method, i);
            NSString *type = argumentType ? [NSString stringWithUTF8String:argumentType] : nil;
            [argumentTypes addObject:type ? type : @""];
            if (argumentType) free(argumentType);
        }
        _argumentTypeEncodings = argumentTypes;
    }
    return self;
}

@end

@implementation LFClassPropertyInfo

- (instancetype)initWithProperty:(objc_property_t)property {
    if (!property) return nil;
    self = [self init];
    _property = property;
    const char *name = property_getName(property);
    if (name) {
        _name = [NSString stringWithUTF8String:name];
    }
    
    LFEncodingType type = 0;
    unsigned int attrCount;
    objc_property_attribute_t *attrs = property_copyAttributeList(property, &attrCount);
    for (unsigned int i = 0; i < attrCount; i++) {
        switch (attrs[i].name[0]) {
            case 'T': { // Type encoding
                if (attrs[i].value) {
                    _typeEncoding = [NSString stringWithUTF8String:attrs[i].value];
                    type = LFEncodingGetType(attrs[i].value);
                    if ((type & LFEncodingTypeMask) == LFEncodingTypeObject) {
                        size_t len = strlen(attrs[i].value);
                        if (len > 3) {
                            char name[len - 2];
                            name[len - 3] = '\0';
                            memcpy(name, attrs[i].value + 2, len - 3);
                            _cls = objc_getClass(name);
                        }
                    }
                }
            } break;
            case 'V': { // Instance variable
                if (attrs[i].value) {
                    _ivarName = [NSString stringWithUTF8String:attrs[i].value];
                }
            } break;
            case 'R': {
                type |= LFEncodingTypePropertyReadonly;
            } break;
            case 'C': {
                type |= LFEncodingTypePropertyCopy;
            } break;
            case '&': {
                type |= LFEncodingTypePropertyRetain;
            } break;
            case 'N': {
                type |= LFEncodingTypePropertyNonatomic;
            } break;
            case 'D': {
                type |= LFEncodingTypePropertyDynamic;
            } break;
            case 'W': {
                type |= LFEncodingTypePropertyWeak;
            } break;
            case 'G': {
                type |= LFEncodingTypePropertyCustomGetter;
                if (attrs[i].value) {
                    _getter = [NSString stringWithUTF8String:attrs[i].value];
                }
            } break;
            case 'S': {
                type |= LFEncodingTypePropertyCustomSetter;
                if (attrs[i].value) {
                    _setter = [NSString stringWithUTF8String:attrs[i].value];
                }
            } break;
            default: break;
        }
    }
    if (attrs) {
        free(attrs);
        attrs = NULL;
    }
    
    _type = type;
    if (_name.length) {
        if (!_getter) {
            _getter = _name;
        }
        if (!_setter) {
            _setter = [NSString stringWithFormat:@"set%@%@:", [_name substringToIndex:1].uppercaseString, [_name substringFromIndex:1]];
        }
    }
    return self;
}

@end

@implementation LFClassInfo {
    BOOL _needUpdate;
}

- (instancetype)initWithClass:(Class)cls {
    if (!cls) return nil;
    self = [super init];
    _cls = cls;
    _superCls = class_getSuperclass(cls);
    _isMeta = class_isMetaClass(cls);
    if (!_isMeta) {
        _metaCls = objc_getMetaClass(class_getName(cls));
    }
    _name = NSStringFromClass(cls);
    [self _update];

    _superClassInfo = [self.class lf_classInfoWithClass:_superCls];
    return self;
}

- (void)_update {
    _ivarInfos = nil;
    _methodInfos = nil;
    _propertyInfos = nil;
    
    Class cls = self.cls;
    unsigned int methodCount = 0;
    Method *methods = class_copyMethodList(cls, &methodCount);
    if (methods) {
        NSMutableDictionary *methodInfos = [NSMutableDictionary new];
        _methodInfos = methodInfos;
        for (unsigned int i = 0; i < methodCount; i++) {
            LFClassMethodInfo *info = [[LFClassMethodInfo alloc] initWithMethod:methods[i]];
            if (info.name) methodInfos[info.name] = info;
        }
        free(methods);
    }
    unsigned int propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList(cls, &propertyCount);
    if (properties) {
        NSMutableDictionary *propertyInfos = [NSMutableDictionary new];
        _propertyInfos = propertyInfos;
        for (unsigned int i = 0; i < propertyCount; i++) {
            LFClassPropertyInfo *info = [[LFClassPropertyInfo alloc] initWithProperty:properties[i]];
            if (info.name) propertyInfos[info.name] = info;
        }
        free(properties);
    }
    
    unsigned int ivarCount = 0;
    Ivar *ivars = class_copyIvarList(cls, &ivarCount);
    if (ivars) {
        NSMutableDictionary *ivarInfos = [NSMutableDictionary new];
        _ivarInfos = ivarInfos;
        for (unsigned int i = 0; i < ivarCount; i++) {
            LFClassIvarInfo *info = [[LFClassIvarInfo alloc] initWithIvar:ivars[i]];
            if (info.name) ivarInfos[info.name] = info;
        }
        free(ivars);
    }
    _needUpdate = NO;
}

- (void)setNeedUpdate {
    _needUpdate = YES;
}

+ (instancetype)lf_classInfoWithClass:(Class)cls {
    if (!cls) return nil;
    static CFMutableDictionaryRef classCache;
    static CFMutableDictionaryRef metaCache;
    static dispatch_once_t onceToken;
    static dispatch_semaphore_t lock;
    dispatch_once(&onceToken, ^{
        classCache = CFDictionaryCreateMutable(CFAllocatorGetDefault(), 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
        metaCache = CFDictionaryCreateMutable(CFAllocatorGetDefault(), 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
        lock = dispatch_semaphore_create(1);
    });
    dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
    LFClassInfo *info = CFDictionaryGetValue(class_isMetaClass(cls) ? metaCache : classCache, (__bridge const void *)(cls));
    if (info && info->_needUpdate) {
        [info _update];
    }
    dispatch_semaphore_signal(lock);
    if (!info) {
        info = [[LFClassInfo alloc] initWithClass:cls];
        if (info) {
            dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
            CFDictionarySetValue(info.isMeta ? metaCache : classCache, (__bridge const void *)(cls), (__bridge const void *)(info));
            dispatch_semaphore_signal(lock);
        }
    }
    return info;
}

+ (instancetype)lf_classInfoWithClassName:(NSString *)className {
    Class cls = NSClassFromString(className);
    return [self lf_classInfoWithClass:cls];
}

@end
