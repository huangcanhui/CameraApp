//
//  APIClient.h
//  CameraApp
//
//  Created by aieffei on 2018/11/7.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * 网络请求成功时的回调
 */
typedef void (^HttpSuccessBlock)(id json);
/**
 * 网络请求失败时的回调
 */
typedef void (^HttpFailureBlock)(NSError *error);
/**
 * 下载进度的回调
 */
typedef void (^HttpDownloadProgressBlock)(CGFloat progress);
/**
 * 上传进度的回调
 */
typedef void (^HttpUploadProgressBlock)(CGFloat progress);

NS_ASSUME_NONNULL_BEGIN

@interface APIClient : NSObject
/**
 * GET网络请求方式
 * @param path 请求的地址
 * @param params 请求参数
 * @param success 成功的回调
 * @param failure 失败的回调
 */
+ (void)getWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;

/**
 * POST网络请求方式
 * @param path 请求的地址
 * @param params 参数
 * @param success 成功的回调
 * @param failure 失败的回调
 */
+ (void)postWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;

/**
 * 下载文件
 * @param path 请求的地址
 * @param success 成功的回调
 * @param failure 失败的回调
 * @param progress 下载进度
 */
+ (void)downloadWithPath:(NSString *)path success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure progress:(HttpDownloadProgressBlock)progress;

/**
 * 上传图片
 * @param path 请求的地址
 * @param params 参数
 * @param thumbName 上传的key
 * @param image 图片
 * @param success 成功的回调
 * @param failure 失败的回调
 * @param progress 上传进度
 */
+ (void)uploadImageWithPath:(NSString *)path params:(NSDictionary *)params thumbName:(NSString *)thumbName image:(UIImage *)image success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure progress:(HttpUploadProgressBlock)progress;

@end

NS_ASSUME_NONNULL_END
