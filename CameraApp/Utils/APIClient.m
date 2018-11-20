//
//  APIClient.m
//  CameraApp
//
//  Created by aieffei on 2018/11/7.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "APIClient.h"
#import <AFNetworking/AFNetworking.h>

static NSString *baseUrl = SERVER_URL;

@interface AFHttpClient : AFHTTPSessionManager
/**
 * 单例
 */
+ (instancetype)shareClient;

@end

@implementation AFHttpClient

+ (instancetype)shareClient
{
    static AFHttpClient *client = nil;
    static dispatch_once_t oncetoken;
    dispatch_once(&oncetoken, ^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        client = [[AFHttpClient alloc] initWithBaseURL:[NSURL URLWithString:baseUrl] sessionConfiguration:configuration];
        //接收的参数类型
        client.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/plain", @"text/gif", nil];
        //设置超时时间, 默认为60
        client.requestSerializer.timeoutInterval = 40;
        //安全策略
        client.securityPolicy = [AFSecurityPolicy defaultPolicy];
    });
    return client;
}

@end

@implementation APIClient

+ (void)getWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure
{
    //获取完整的url路径
    NSString *url = [baseUrl stringByAppendingString:path];
    [[AFHttpClient shareClient] GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

+ (void)postWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure
{
    //获取完整的url路径
    NSString *url = [baseUrl stringByAppendingString:path];
    [[AFHttpClient shareClient] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

+ (void)downloadWithPath:(NSString *)path success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure progress:(HttpDownloadProgressBlock)progress
{
    //获取完整的url路径
    NSString *url = [baseUrl stringByAppendingString:path];
    //下载
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSessionDownloadTask *downloadTask = [[AFHttpClient shareClient] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        progress(downloadProgress.fractionCompleted);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //获取沙河cache路径
        NSURL *documentDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            failure(error);
        } else {
            success(filePath.path);
        }
    }];
    [downloadTask resume];
}

+ (void)uploadImageWithPath:(NSString *)path params:(NSDictionary *)params thumbName:(NSString *)thumbName image:(UIImage *)image success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure progress:(HttpUploadProgressBlock)progress
{
    //获取完整的url路径
    NSString *url = [baseUrl stringByAppendingString:path];
    NSData *data = UIImagePNGRepresentation(image);
    [[AFHttpClient shareClient] POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:thumbName fileName:@"01.png" mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end
