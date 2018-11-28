//
//  ImageObject.m
//  CameraApp
//
//  Created by aieffei on 2018/11/21.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "ImageObject.h"

@implementation ImageObject

- (CGSize)sizeOfRotationAngle:(CGFloat)angle FromSize:(CGSize)originalSize deviceOrientation:(UIDeviceOrientation)deviceOrientation
{
    if (angle >= M_PI * 2) {
        angle = 0;
    }
    CGFloat containerWidth = originalSize.width;
    CGFloat containerHeight = originalSize.height;
//    CGFloat containerHeight = 4 * containerWidth / 3;
    CGFloat angleB = atan2(containerWidth, containerHeight);
    CGFloat margin = angle;
    if (deviceOrientation == UIDeviceOrientationPortrait) {
        if (margin > M_PI) {
            margin = 2 * M_PI - angle;
        }
        
        CGFloat width = containerWidth * sin(angleB) / sin(margin + angleB);
        CGFloat height = containerHeight / containerWidth * width;
//        return CGSizeMake(width, 4 * width / 3);
        return CGSizeMake(width, height);
        
    }else if (deviceOrientation == UIDeviceOrientationPortraitUpsideDown){
        margin = fabs(angle - M_PI);
        
        CGFloat width = containerWidth * sin(angleB) / sin(margin + angleB);
        CGFloat height = containerHeight / containerWidth * width;
//        return CGSizeMake(width, 4 * width / 3);
        return CGSizeMake(width, height);
    }else if (deviceOrientation == UIDeviceOrientationLandscapeLeft){
        margin = fabs(angle - 3 * M_PI_2);
        
        CGFloat height = containerWidth * sin(angleB) / sin(margin + angleB);
        CGFloat width = containerHeight / containerWidth * (height) ;
//        return CGSizeMake(4 * height / 3, height);
        return CGSizeMake(width, height);
    }else{
        margin = fabs(angle - M_PI_2);
        
        CGFloat height = containerWidth * sin(angleB) / sin(margin + angleB);
        CGFloat width = containerHeight / containerWidth * (height);
//        return CGSizeMake(4 * height / 3, height);
        return CGSizeMake(width, height);
    }
}

//旋转一定角度
- (UIImage *)imageByStraightenImage:(UIImage *)image andAngle:(CGFloat)angle deviceOrientation:(UIDeviceOrientation)deviceOrientation shouldFlipRotation:(BOOL)isFrontCamera
{
    if (!image) return nil;
    
    CIImage* ciImage = [CIImage imageWithCGImage:image.CGImage];
    
    ciImage = [ciImage imageByApplyingTransform:CGAffineTransformMakeRotation(-M_PI/2.0)];
    CGPoint origin = [ciImage extent].origin;
    ciImage = [ciImage imageByApplyingTransform:CGAffineTransformMakeTranslation(-origin.x, -origin.y)];
    
    CGFloat angleToCalcSize = angle;
    if (isFrontCamera) {
        angleToCalcSize = 2 * M_PI - angle;
    }
    CGSize finalSize = [self sizeOfRotationAngle:angleToCalcSize FromSize:ciImage.extent.size deviceOrientation:deviceOrientation];
    
    ciImage = [ciImage imageByApplyingTransform:CGAffineTransformMakeRotation(2*M_PI - angle)];
    origin = [ciImage extent].origin;
    ciImage = [ciImage imageByApplyingTransform:CGAffineTransformMakeTranslation(-origin.x, -origin.y)];
    
    CGPoint finalOrigin = CGPointMake((ciImage.extent.size.width - finalSize.width)/2, (ciImage.extent.size.height - finalSize.height)/2);
    ciImage = [ciImage imageByCroppingToRect:CGRectMake(finalOrigin.x, finalOrigin.y, finalSize.width, finalSize.height)];
    
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:ciImage fromRect:[ciImage extent]];
    UIImage *outputImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    return outputImage;
}

@end
