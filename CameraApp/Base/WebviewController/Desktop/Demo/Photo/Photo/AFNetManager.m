//
//  AFNetManager.m
//  Cybespoke
//
//  Created by pengpeng on 15/10/8.
//  Copyright © 2015年 pengpeng. All rights reserved.
//
#import "AFNetManager.h"
#import <AFNetworking.h>

@implementation AFNetManager

+ (void)uploadUserData:(User *)user success:(void (^)(id))success fail:(void (^)(NSError *))fail
{
    
    //NSString *url = @"http://192.168.1.36:8080/app/app/s/camera/upload-picture/";
    NSString *url = @"http://192.168.1.36:8080/app/app/s/camera/upload-picture/";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFJSONRequestSerializer *reqSer = [AFJSONRequestSerializer serializer];
    
    //设置上传格式
    NSString *content = [[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",@"AaB03x"];
    //设置请求的类型
    [reqSer setValue:content forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = reqSer;
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:user.userName forKey:@"userName"];
    [dict setObject:[NSNumber numberWithInteger:user.height] forKey:@"userHeight"];
    [dict setObject:[NSNumber numberWithFloat:user.weight] forKey:@"userWeight"];
    [dict setObject:user.phoneNum forKey:@"userPhone"];
    
    [manager POST:url parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

        [formData appendPartWithFileData:[NSData dataWithContentsOfFile:user.frontPath]
                                    name:@"pic1"
                                fileName:user.frontPath
                                mimeType:@"image/jpg"];
        [formData appendPartWithFileData:[NSData dataWithContentsOfFile:user.sidePath]
                                    name:@"pic2"
                                fileName:user.sidePath
                                mimeType:@"image/jpg"];
        [formData appendPartWithFileData:[NSData dataWithContentsOfFile:user.backgroundPath]
                                    name:@"pic3"
                                fileName:user.backgroundPath
                                mimeType:@"image/jpg"];
        
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        fail(error);
    }];

}
@end