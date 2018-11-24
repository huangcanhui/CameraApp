//
//  CHCompressImageManager.m
//  CameraApp
//
//  Created by aieffei on 2018/11/24.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CHCompressImageManager.h"

@implementation CHCompressImageManager

+ (UIImage *)zipScaleWithImage:(UIImage *)sourceImage
{
    //进行图像的尺寸压缩
    CGSize imageSize = sourceImage.size; //去除要压缩的image尺寸
    //获取图片宽高
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    //1.宽度大于1280（宽高比不按照2来算，按照1来算）
    if (width > 1280 && height > 1280) {
        if (width > height) {
            CGFloat scale = height / width;
            width = 1280;
            height = width * scale;
        } else {
            CGFloat scale = width / height;
            height = 1280;
            width = height * scale;
        }
    } else if (width > 1280 && height < 1280){ //2.宽大于1280高小于1280
        CGFloat scale = height / width;
        width = 1280;
        height = height * scale;
    } else if (width < 1280 && height > 1280) { //3.宽小于1280高大于1280
        CGFloat scale = width / height;
        height = 1280;
        width = height * scale;
    } else { //4.宽高都小于1280
        
    }
    //进行尺寸重汇
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [sourceImage drawInRect:CGRectMake(0, 0, width, height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (NSData *)zipNSDataWithImage:(UIImage *)sourceImage
{
    UIImage *image = [self zipScaleWithImage:sourceImage];
    //进行图像的画面质量压缩
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    if (data.length > 100 * 1024) {
        if (data.length > 1024 * 1024) { //1M以及以上
            data = UIImageJPEGRepresentation(image, 0.7);
        } else if (data.length > 512 * 1024) { //0.5M - 1M
            data = UIImageJPEGRepresentation(image, 0.8);
        } else if (data.length > 200 * 1024) { //0.25M - 0.5M
            data = UIImageJPEGRepresentation(image, 0.9);
        }
    }
    return data;
}

@end
