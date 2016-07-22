//
//  CALayer+LFAdd.h
//
//
//  Created by guoyaoyuan on 14-5-10.
//  Copyright (c) 2014 live Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

/**
 Provides extensions for `CALayer`.
 */
@interface CALayer (LFAdditions)

/**
 Take snapshot without transform, image's size equals to bounds.
 */
- (UIImage *)lf_snapshotImage;

/**
 Take snapshot without transform, PDF's page size equals to bounds.
 */
- (NSData *)lf_snapshotPDF;

/**
 Shortcut to set the layer's shadow
 
 @param color  Shadow Color
 @param offset Shadow offset
 @param radius Shadow radius
 */
- (void)lf_setLayerShadow:(UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius;

/**
 Remove all sublayers.
 */
- (void)lf_removeAllSublayers;

@property (nonatomic, setter=setLf_left:, getter=lf_left) CGFloat left;    ///< Shortcut for frame.origin.x.
@property (nonatomic, setter=setLf_top:, getter=lf_top) CGFloat top;     ///< Shortcut for frame.origin.y
@property (nonatomic, setter=setLf_right:, getter=lf_right) CGFloat right;   ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic, setter=setLf_bottom:, getter=lf_bottom) CGFloat bottom;  ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic, setter=setLf_width:, getter=lf_width) CGFloat width;   ///< Shortcut for frame.size.width.
@property (nonatomic, setter=setLf_height:, getter=lf_height) CGFloat height;  ///< Shortcut for frame.size.height.
@property (nonatomic, setter=setLf_center:, getter=lf_center) CGPoint center;  ///< Shortcut for center (Add)
@property (nonatomic, setter=setLf_centerX:, getter=lf_centerX) CGFloat centerX; ///< Shortcut for center.x
@property (nonatomic, setter=setLf_centerY:, getter=lf_centerY) CGFloat centerY; ///< Shortcut for center.y
@property (nonatomic, setter=setLf_origin:, getter=lf_origin) CGPoint origin;  ///< Shortcut for frame.origin.
@property (nonatomic, getter=frameSize, setter=setFrameSize:) CGSize  size; ///< Shortcut for frame.size.


@property (nonatomic, setter=setLf_transformRotation:, getter=lf_transformRotation) CGFloat transformRotation;     ///< key path "tranform.rotation"
@property (nonatomic, setter=setLf_transformRotationX:, getter=lf_transformRotationX) CGFloat transformRotationX;    ///< key path "tranform.rotation.x"
@property (nonatomic, setter=setLf_transformRotationY:, getter=lf_transformRotationY) CGFloat transformRotationY;    ///< key path "tranform.rotation.y"
@property (nonatomic, setter=setLf_transformRotationZ:, getter=lf_transformRotationZ) CGFloat transformRotationZ;    ///< key path "tranform.rotation.z"
@property (nonatomic, setter=setLf_transformScale:, getter=lf_transformScale) CGFloat transformScale;        ///< key path "tranform.scale"
@property (nonatomic, setter=setLf_transformScaleX:, getter=lf_transformScaleX) CGFloat transformScaleX;       ///< key path "tranform.scale.x"
@property (nonatomic, setter=setLf_transformScaleY:, getter=lf_transformScaleY) CGFloat transformScaleY;       ///< key path "tranform.scale.y"
@property (nonatomic, setter=setLf_transformScaleZ:, getter=lf_transformScaleZ) CGFloat transformScaleZ;       ///< key path "tranform.scale.z"
@property (nonatomic, setter=setLf_transformTranslationX:, getter=lf_transformTranslationX) CGFloat transformTranslationX; ///< key path "tranform.translation.x"
@property (nonatomic, setter=setLf_transformTranslationY:, getter=lf_transformTranslationY) CGFloat transformTranslationY; ///< key path "tranform.translation.y"
@property (nonatomic, setter=setLf_transformTranslationZ:, getter=lf_transformTranslationZ) CGFloat transformTranslationZ; ///< key path "tranform.translation.z"

/**
 做3D效果时，可以很方便用这个调整
 Shortcut for transform.m34, -1/1000 is a good value.
 It should be set before other transform shortcut.
 */
@property (nonatomic, assign) CGFloat lf_transformDepth;


/**
 Add a fade animation to layer's contents when the contents is changed.
 
 @param duration Animation duration
 @param curve    Animation curve.
 */
- (void)lf_addFadeAnimationWithDuration:(NSTimeInterval)duration curve:(UIViewAnimationCurve)curve;

/**
 Cancel fade animation which is added with "-addFadeAnimationWithDuration:curve:".
 */
- (void)lf_removePreviousFadeAnimation;

@end
