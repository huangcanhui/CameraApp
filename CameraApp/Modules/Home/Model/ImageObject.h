//
//  ImageObject.h
//  CameraApp
//
//  Created by aieffei on 2018/11/21.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageObject : NSObject
/**
 * 手机旋转的角度
 */
- (CGSize)sizeOfRotationAngle:(CGFloat)angle FromSize:(CGSize)originalSize deviceOrientation:(UIDeviceOrientation)deviceOrientation;
/**
 * 旋转一定角度后截取的图片
 */
- (UIImage *)imageByStraightenImage:(UIImage *)image andAngle:(CGFloat)angle deviceOrientation:(UIDeviceOrientation)deviceOrientation shouldFlipRotation:(BOOL)isFrontCamera;

@end

NS_ASSUME_NONNULL_END
