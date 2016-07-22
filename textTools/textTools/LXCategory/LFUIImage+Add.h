//
//  UIImage+LFAdd.h
//
//
//  Created by guoyaoyuan on 13-4-4.
//  Copyright (c) 2013 live Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Provide some commen method for `UIImage`.
 Image process is based on CoreGraphic and vImage.
 */
@interface UIImage (LFAdditions)
#pragma mark - 图像拉伸

/*!
    按照图片的中心点拉伸图片
    @result 拉伸后的图片
 */
- (UIImage *)lf_stretchableImageWithCenter;

#pragma mark - 图像解码
///=============================================================================
/// @name 图像解码
///=============================================================================

/**
 返回解码的Image。
 
 通常当Image创建时，内部图像是压缩的，所以当显示到屏幕时，图像会在主线程解压，会降低绘制帧数。
 用这个方法预先解码后，就不会有额外的主线程解压阻塞了。
 
 @return 解码后的图像。 (如果图像已经被解码，那直接返回self)
 */
- (UIImage *)lf_imageByDecoded;

/**
 该图像是否已经被解码 (只是个tint，不会有其他任何影响)
 */
@property (nonatomic, assign) BOOL isImageDecoded;


#pragma mark - 图像创建
///=============================================================================
/// @name 图像创建
///=============================================================================

/**
 从gif创建动态图像。创建完成后，可以通过.images属性来访问所有帧。
 如果data不是gif，这个方法就和[UIImage imageWithData:data scale:scale]一样了。

 @discussion     用这个方法创建的动画有比较好的显示性能，但是会耗费较多内存 (width * height * frames)
                 所以这个方法只适合用于显示小gif，例如小表情。
                 如果需要显示较大的gif，最好换成 LFGIFImage
 */
+ (UIImage *)lf_imageWithSmallGIFData:(NSData *)data scale:(CGFloat)scale;

/**
 判断一个data是否是动画gif。
 只有当是gif并且包含多帧图像时，才返回YES。
 */
+ (BOOL)lf_isAnimatedGIFData:(NSData *)data;

/**
 由PDF创建Image。 (如果PDF是多页，则只读取第一页)
 */
+ (UIImage *)lf_imageWithPDF:(id)dataOrPath;

/**
 由PDF创建Image。 (如果PDF是多页，则只读取第一页)
 */
+ (UIImage *)lf_imageWithPDF:(id)dataOrPath size:(CGSize)size;

/**
 创建一个emoji图片。
 
 @discussion Apple Emoji 是正方形的图片，原始尺寸是160px。
 
 @param emoji single emoji, such as @"😄".
 @param size  image's size.
 */
+ (UIImage *)lf_imageWithEmoji:(NSString *)emoji size:(CGFloat)size;

/**
 创建一个 1x1 大小的纯色图片
 */
+ (UIImage *)lf_imageWithColor:(UIColor *)color;

/**
 创建一张纯色图片
 */
+ (UIImage *)lf_imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 用QuartZ画出一个图片
 */
+ (UIImage *)lf_imageWithSize:(CGSize)size drawBlock:(void (^)(CGContextRef context))drawBlock;


#pragma mark - 图片信息
///=============================================================================
/// @name 图片信息
///=============================================================================

/**
 获取图片上某一点的颜色
 
 @param point  图片内的一个点。范围是 [0, image.width-1],[0, image.height-1]
               超出图片范围则返回nil
 */
- (UIColor *)lf_colorAtPoint:(CGPoint)point;

/**
 该图片是否有alpha通道
 */
- (BOOL)lf_hasAlphaChannel;


#pragma mark - 修改图片
///=============================================================================
/// @name 修改图片
///=============================================================================

/// 在rect里绘制图片，支持contentMode。 (需要预先准备GraphContext)
- (void)lf_drawInRect:(CGRect)rect withContentMode:(UIViewContentMode)contentMode clipsToBounds:(BOOL)clips;

/// 调整图片大小 (内容可能会被拉伸)
- (UIImage *)lf_imageByResizeToSize:(CGSize)size;

/// 调整图片大小 (内容会根据contentMode来调整)
- (UIImage *)lf_imageByResizeToSize:(CGSize)size contentMode:(UIViewContentMode)contentMode;

/// 从内部裁剪出一块儿。
- (UIImage *)lf_imageByCropToRect:(CGRect)rect;


/**
 用 edge inset 来调整图片
 @param insets  Inset (positive) for each of the edges, values can be negative to 'outset'.
 @param color   Extend edge's fill color, nil means clear color.
 */
- (UIImage *)lf_imageByInsetEdge:(UIEdgeInsets)insets withColor:(UIColor *)color;

/**
 为图片裁剪出圆角
 @param radius  圆角的半径(如果超出图片宽高，内部会调整以适应图片)
 */
- (UIImage *)lf_imageByRoundCornerRadius:(CGFloat)radius;

/**
 为图片裁剪出圆角
 @param radius  圆角的半径(如果超出图片宽高，内部会调整以适应图片)
 @param corners  裁剪哪几个角
 @param borderWidth  可以加一个border
 */
- (UIImage *)lf_imageByRoundCornerRadius:(CGFloat)radius
                              corners:(UIRectCorner)corners
                          borderWidth:(CGFloat)borderWidth;

/**
 旋转图片 (中心旋转)
 @param radians   旋转弧度 (逆时针).⟲
 @param fitSize   YES: 旋转后，图片大小会扩大以包含全部内容
                  NO: 旋转后，图片大小不变，某些内容会被裁剪
 */
- (UIImage *)lf_imageByRotate:(CGFloat)radians fitSize:(BOOL)fitSize;


/// 向左旋转90° ⤺ (图片宽高会对调)
- (UIImage *)lf_imageByRotateLeft90;

/// 向右旋转90° ⤺ (图片宽高会对调)
- (UIImage *)lf_imageByRotateRight90;

/// 旋转180°
- (UIImage *)lf_imageByRotate180;

/// 上下翻转 ⥯
- (UIImage *)lf_imageByFlipVertical;

/// 左右翻转 ⇋
- (UIImage *)lf_imageByFlipHorizontal;


#pragma mark - 图片效果
///=============================================================================
/// @name 图片效果
///=============================================================================

/// 给图片染色(Tint Color) (就像用有色眼镜看图片)
- (UIImage *)lf_imageByTintColor:(UIColor *)color;

/// 黑白化
- (UIImage *)lf_imageByGrayscale;

/// 灰毛玻璃效果 (适合在里面显示任何内容)
- (UIImage *)lf_imageByBlurSoft;

/// 白色毛玻璃效果 (苹果内置)(适合在里面显示任何内容，除了纯白色文本) 和上拉控制中心、桌面文件夹效果一样
- (UIImage *)lf_imageByBlurLight;

/// 亮白色毛玻璃效果 (苹果内置)(适合在里面显示深色文字)
- (UIImage *)lf_imageByBlurExtraLight;

/// 黑色色毛玻璃效果 (苹果内置)(适合在里面显示浅色文字) 和下拉通知中心的效果一样
- (UIImage *)lf_imageByBlurDark;

/// 模糊一张图片，并添加tintColor
- (UIImage *)lf_imageByBlurWithTint:(UIColor *)tintColor;

/**
 这是苹果官方提供的一个方法，用于调整图片的模糊、饱和度、蒙板等方法。
 
 Applies a blur, tint color, and saturation adjustment to this image,
 optionally within the area specified by @a maskImage.
 
 @param blurRadius     The radius of the blur in points, 0 means no blur effect.
 
 @param tintColor      An optional UIColor object that is uniformly blended with
                       the result of the blur and saturation operations. The
                       alpha channel of this color determines how strong the
                       tint is. nil means no tint.
 
 @param tintBlendMode  The @a tintColor blend mode. Default is kCGBlendModeNormal (0).
 
 @param saturation     A value of 1.0 produces no change in the resulting image.
                       Values less than 1.0 will desaturation the resulting image
                       while values greater than 1.0 will have the opposite effect.
                       0 means gray scale.
 
 @param maskImage      If specified, @a inputImage is only modified in the area(s)
                       defined by this mask.  This must be an image mask or it
                       must meet the requirements of the mask parameter of
                       CGContextClipToMask.
 
 @return               image with effect, or nil if an error occurs (e.g. no
                       enough memory).
 */
- (UIImage *)lf_imageByBlurRadius:(CGFloat)blurRadius
                     tintColor:(UIColor *)tintColor
                      tintMode:(CGBlendMode)tintBlendMode
                    saturation:(CGFloat)saturation
                     maskImage:(UIImage *)maskImage;


/**
 * 模糊一张图片 (只模糊，不调整颜色)
 *
 * @param radius           模糊半径(力度) iOS7模糊大约是40
 */
- (UIImage *)lf_blurredImageWithRadius:(CGFloat)radius;

/**
 * 模糊一张图片
 *
 * @param radius           模糊半径(力度) iOS7模糊大约是40
 * @param iterations       模糊迭代次数 (次数越多、计算量越大、模糊越平滑，通常3就足够了)
 * @param tintColor        模糊后着色 (如果该值为nil,则不会进行着色)
 * @param tintColorPercent 着色的百分比 (0.0~1.0)
 * @param blendMode        着色的混合模式
 */
- (UIImage *)lf_blurredImageWithRadius:(CGFloat)radius
                         iterations:(NSUInteger)iterations
                          tintColor:(UIColor *)tintColor
                   tintColorPercent:(CGFloat)tintColorPercent
                          blendMode:(CGBlendMode)blendMode;


@end





#pragma mark - Helper functions

/**
 Create a decoded image (may useful for display), see `-imageByDecoded`.
 */
CGImageRef CGImageCreateDecoded(CGImageRef imageRef);
