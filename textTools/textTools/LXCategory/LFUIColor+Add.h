//
//  UIColor+LFAdd.h
//
//
//  Created by guoyaoyuan on 13-4-4.
//  Copyright (c) 2013 live Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN UIColor *LFUIColorWithHexRGB(uint32_t rgbValue);
UIKIT_EXTERN UIColor *LFUIColorWithHexRGBA(uint32_t rgbaValue);

UIKIT_EXTERN UIColor *LFUIColorWithRGBA(uint8_t r, uint8_t g, uint8_t b, CGFloat a);
UIKIT_EXTERN UIColor *LFUIColorWithRGB(uint8_t r, uint8_t g, uint8_t b);

extern void LF_RGB2HSL(CGFloat r, CGFloat g, CGFloat b,
                       CGFloat *h, CGFloat *s, CGFloat *l);

extern void LF_HSL2RGB(CGFloat h, CGFloat s, CGFloat l,
                       CGFloat *r, CGFloat *g, CGFloat *b);

extern void LF_RGB2HSB(CGFloat r, CGFloat g, CGFloat b,
                       CGFloat *h, CGFloat *s, CGFloat *v);

extern void LF_HSB2RGB(CGFloat h, CGFloat s, CGFloat v,
                       CGFloat *r, CGFloat *g, CGFloat *b);

extern void LF_RGB2CMYK(CGFloat r, CGFloat g, CGFloat b,
                        CGFloat *c, CGFloat *m, CGFloat *y, CGFloat *k);

extern void LF_CMYK2RGB(CGFloat c, CGFloat m, CGFloat y, CGFloat k,
                        CGFloat *r, CGFloat *g, CGFloat *b);

extern void LF_HSB2HSL(CGFloat h, CGFloat s, CGFloat b,
                       CGFloat *hh, CGFloat *ss, CGFloat *ll);

extern void LF_HSL2HSB(CGFloat h, CGFloat s, CGFloat l,
                       CGFloat *hh, CGFloat *ss, CGFloat *bb);

extern void LF_RGB2YUV(CGFloat R, CGFloat G, CGFloat B,
                       CGFloat *Y, CGFloat *U, CGFloat *V);

extern void LF_YUV2RGB(CGFloat Y, CGFloat U, CGFloat V,
                       CGFloat *R, CGFloat *G, CGFloat *B);

#ifndef UIColorRGB   //e.g. UIColorRGB(0.5, 0.2, 0.3)
#define UIColorRGB(r, g, b)     [UIColor colorWithRed:(r) green:(g) blue:(b) alpha: 1]
#endif
#ifndef UIColorRGBA  //e.g. UIColorRGBA(0.5, 0.2, 0.3, 1)
#define UIColorRGBA(r, g, b, a) [UIColor colorWithRed:(r) green:(g) blue:(b) alpha: (a)]
#endif
#ifndef UIColorHSB   //e.g. UIColorHSB(0, 1, 0, 0.5)
#define UIColorHSB(h, s, b)     [UIColor colorWithHue:(h) saturation:(s) brightness:(b) alpha:1]
#endif
#ifndef UIColorHSBA  //e.g. UIColorHSBA(1,0,0,0.5)
#define UIColorHSBA(h, s, b, a) [UIColor colorWithHue:(h) saturation:(s) brightness:(b) alpha:(a)]
#endif
#ifndef UIColorHSL   //e.g. UIColorHSL(1,0,0.5)
#define UIColorHSL(h, s, l)     [UIColor colorWithHue:(h) saturation:(s) lightness:(l) alpha:1]
#endif
#ifndef UIColorHSLA  //e.g. UIColorHSLA(1,0,0,0.5)
#define UIColorHSLA(h, s, l, a) [UIColor colorWithHue:(h) saturation:(s) lightness:(l) alpha:(a)]
#endif
#ifndef UIColorCMYK  //e.g. UIColorCMYK(0,0,1,0.5)
#define UIColorCMYK(c, m, y, k) [UIColor colorWithCyan:(c) magenta:(m) yellow:(y) black:(k) alpha:1]
#endif
#ifndef UIColorCMYKA //e.g. UIColorCMYKA(0,0,1,0,0.5)
#define UIColorCMYKA(c, m, y, k, a) [UIColor colorWithCyan:(c) magenta:(m) yellow:(y) black:(k) alpha:(a)]
#endif
#ifndef UIColorHex   //e.g. UIColorHex(#66ccff)  UIColorHex(66CCFF88)  (支持 rgb/rgba/rrggbb/rrggbbaa)
#define UIColorHex(hex)   [UIColor lf_colorWithHexString:(@#hex)]
#endif

/**
 UIColor的创建，转换等。支持RGB,HSB,HSL,CMYK,Hex.

 
 | 色彩空间     | 含义                                |
 |-------------|----------------------------------------|
 | RGB *       | Red, Green, Blue                       |
 | HSB(HSV) *  | Hue, Saturation, Brightness (Value)    |
 | HSL         | Hue, Saturation, Lightness             |
 | CMYK        | Cyan, Magenta, Yellow, Black           |
 苹果默认支持 RGB 和 HSB.
 
 这个 Category 里面的参数都是 0.0 到 1.0 之间的。超出范围时，方法内会裁剪到合法范围。
 
 如果需要更多色彩空间的转换 (CIEXYZ,Lab,YUV...),
 看这个repo: https://github.com/ibireme/yy_color_convertor
 */
@interface UIColor (LFAdditions)


#pragma mark - Create a UIColor Object
///=============================================================================
/// @name Creating a UIColor Object
///=============================================================================

/**
 Creates and returns a color object using the specified opacity
 and HSL color space component values.

 @param hue        The hue component of the color object in the HSL color space,
                   specified as a value from 0.0 to 1.0.

 @param saturation The saturation component of the color object in the HSL color space,
                   specified as a value from 0.0 to 1.0.
 
 @param lightness  The lightness component of the color object in the HSL color space,
                   specified as a value from 0.0 to 1.0.
 
 @param alpha      The opacity value of the color object, 
                   specified as a value from 0.0 to 1.0.
 
 @return           The color object. The color information represented by this 
                   object is in the device RGB colorspace.
 */
+ (UIColor *)lf_colorWithHue:(CGFloat)hue
               saturation:(CGFloat)saturation
                lightness:(CGFloat)lightness
                    alpha:(CGFloat)alpha;

/**
 Creates and returns a color object using the specified opacity
 and CMYK color space component values.
 
 @param cyan    The cyan component of the color object in the CMYK color space,
                specified as a value from 0.0 to 1.0.
 
 @param magenta The magenta component of the color object in the CMYK color space,
                specified as a value from 0.0 to 1.0.
 
 @param yellow  The yellow component of the color object in the CMYK color space,
                specified as a value from 0.0 to 1.0.
 
 @param black   The black component of the color object in the CMYK color space,
                specified as a value from 0.0 to 1.0.
 
 @param alpha   The opacity value of the color object,
                specified as a value from 0.0 to 1.0.
 
 @return        The color object. The color information represented by this 
                object is in the device RGB colorspace.
 */
+ (UIColor *)lf_colorWithCyan:(CGFloat)cyan
                   magenta:(CGFloat)magenta
                    yellow:(CGFloat)yellow
                     black:(CGFloat)black
                     alpha:(CGFloat)alpha;

/**
 Creates and returns a color object using the hex RGB color values.
 
 @param rgbValue  The rgb value such as 0x66ccff.
 
 @return          The color object. The color information represented by this
                  object is in the device RGB colorspace.
 */
+ (UIColor *)lf_colorWithRGB:(uint32_t)rgbValue;

/**
 Creates and returns a color object using the hex RGBA color values.
 
 @param rgbaValue  The rgb value such as 0x66ccffff.
 
 @return           The color object. The color information represented by this 
                   object is in the device RGB colorspace.
 */
+ (UIColor *)lf_colorWithRGBA:(uint32_t)rgbaValue;

/**
 Creates and returns a color object using the specified opacity and RGB hex value.
 
 @param rgbValue  The rgb value such as 0x66CCFF.
 
 @param alpha     The opacity value of the color object,
                  specified as a value from 0.0 to 1.0.
 
 @return          The color object. The color information represented by this 
                  object is in the device RGB colorspace.
 */
+ (UIColor *)lf_colorWithRGB:(uint32_t)rgbValue alpha:(CGFloat)alpha;

/**
 支持格式: #rgb #rgba #rrggbb #rrggbbaa 0xrgb ...
 
 `#` 和 "0x" 前缀是可选的。
 如果没有 alpha 部分，则默认 alpha 为 1.0.
 解析失败则返回 nil。
 
 @param hexStr  The hex string value for the new color.
 
 @return        An UIColor object from string, or nil if an error occurs.
 */
+ (UIColor *)lf_colorWithHexString:(NSString *)hexStr;

/**
 和 colorWithHexString 一样，但抛弃 hex 中的 alpha 部分，改为参数传入
 */
+ (UIColor *)lf_colorWithHexString:(NSString *)hexStr alpha:(CGFloat)alpha;

/**
 Creates and returns a color object by add new color.
 
 @param add        the color added
 
 @param blendMode  add color blend mode
 */
- (UIColor *)lf_colorByAddColor:(UIColor *)add blendMode:(CGBlendMode)blendMode;

/**
 Creates and returns a color object by change components.
 
 @param hueDelta         the hue change delta specified as a value 
                         from -1.0 to 1.0. 0 means no change.
 
 @param saturationDelta  the saturation change delta specified as a value 
                         from -1.0 to 1.0. 0 means no change.
 
 @param brightnessDelta  the brightness change delta specified as a value 
                         from -1.0 to 1.0. 0 means no change.
 
 @param alphaDelta       the alpha change delta specified as a value 
                         from -1.0 to 1.0. 0 means no change.
 */
- (UIColor *)lf_colorByChangeHue:(CGFloat)hueDelta
                   saturation:(CGFloat)saturationDelta
                   brightness:(CGFloat)brightnessDelta
                        alpha:(CGFloat)alphaDelta;


#pragma mark - Get color's description
///=============================================================================
/// @name Get color's description
///=============================================================================

/**
 Returns the rgb value in hex.
 @return hex value of RGB,such as 0x66ccff.
 */
- (uint32_t)lf_rgbValue;

/**
 Returns the rgba value in hex.
 
 @return hex value of RGBA,such as 0x66ccffff.
 */
- (uint32_t)lf_rgbaValue;

/**
 Returns the color's RGB value as a hex string (lowercase).
 Such as @"0066cc".
 
 It will return nil when the color space is not RGB
 
 @return The color's value as a hex string.
 */
- (NSString *)lf_hexString;

/**
 Returns the color's RGBA value as a hex string (lowercase).
 Such as @"0066ccff".
 
 It will return nil when the color space is not RGBA
 
 @return The color's value as a hex string.
 */
- (NSString *)lf_hexStringWithAlpha;


#pragma mark - Retrieving Color Information
///=============================================================================
/// @name Retrieving Color Information
///=============================================================================

/**
 Returns the components that make up the color in the HSL color space.
 
 @param hue         On return, the hue component of the color object,
                    specified as a value between 0.0 and 1.0.
 
 @param saturation  On return, the saturation component of the color object,
                    specified as a value between 0.0 and 1.0.
 
 @param lightness   On return, the lightness component of the color object,
                    specified as a value between 0.0 and 1.0.
 
 @param alpha       On return, the alpha component of the color object,
                    specified as a value between 0.0 and 1.0.
 
 @return            YES if the color could be converted, NO otherwise.
 */
- (BOOL)lf_getHue:(CGFloat *)hue
    saturation:(CGFloat *)saturation
     lightness:(CGFloat *)lightness
         alpha:(CGFloat *)alpha;

/**
 Returns the components that make up the color in the CMYK color space.
 
 @param cyan     On return, the cyan component of the color object,
                 specified as a value between 0.0 and 1.0.
 
 @param magenta  On return, the magenta component of the color object,
                 specified as a value between 0.0 and 1.0.
 
 @param yellow   On return, the yellow component of the color object,
                 specified as a value between 0.0 and 1.0.
 
 @param black    On return, the black component of the color object,
                 specified as a value between 0.0 and 1.0.
 
 @param alpha    On return, the alpha component of the color object,
                 specified as a value between 0.0 and 1.0.
 
 @return         YES if the color could be converted, NO otherwise.
 */
- (BOOL)lf_getCyan:(CGFloat *)cyan
        magenta:(CGFloat *)magenta
         yellow:(CGFloat *)yellow
          black:(CGFloat *)black
          alpha:(CGFloat *)alpha;

/**
 The color's red component value in RGB color space.
 The value of this property is a float in the range `0.0` to `1.0`.
 */
@property (nonatomic, readonly, getter=lf_red) CGFloat red;

/**
 The color's green component value in RGB color space.
 The value of this property is a float in the range `0.0` to `1.0`.
 */
@property (nonatomic, readonly, getter=lf_green) CGFloat green;

/**
 The color's blue component value in RGB color space.
 The value of this property is a float in the range `0.0` to `1.0`.
 */
@property (nonatomic, readonly, getter=lf_blue) CGFloat blue;

/**
 The color's hue component value in HSB color space.
 The value of this property is a float in the range `0.0` to `1.0`.
 */
@property (nonatomic, readonly,getter=lf_hue) CGFloat hue;

/**
 The color's saturation component value in HSB color space.
 The value of this property is a float in the range `0.0` to `1.0`.
 */
@property (nonatomic, readonly, getter=lf_saturation) CGFloat saturation;

/**
 The color's brightness component value in HSB color space.
 The value of this property is a float in the range `0.0` to `1.0`.
 */
@property (nonatomic, readonly, getter=lf_brightness) CGFloat brightness;

/**
 The color's alpha component value.
 The value of this property is a float in the range `0.0` to `1.0`.
 */
@property (nonatomic, readonly, getter=lf_alpha) CGFloat alpha;

/**
 The color's colorspace model.
 */
@property (nonatomic, readonly, getter=lf_colorSpaceModel) CGColorSpaceModel colorSpaceModel;

/**
 Readable colorspace string.
 */
@property (nonatomic, readonly, getter=lf_colorSpaceString) NSString *colorSpaceString;
@end
