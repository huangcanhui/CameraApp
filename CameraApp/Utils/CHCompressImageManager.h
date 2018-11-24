//
//  CHCompressImageManager.h
//  CameraApp
//
//  Created by aieffei on 2018/11/24.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//
/*************************** 这是一个对图片进行裁剪压缩的类 *****************************************/

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CHCompressImageManager : NSObject
/**
 * 对图片进行缩处理
 */
+ (UIImage *)zipScaleWithImage:(UIImage *)sourceImage;
/**
 * 对图片进行压处理
 */
+ (NSData *)zipNSDataWithImage:(UIImage *)sourceImage;

@end

NS_ASSUME_NONNULL_END
