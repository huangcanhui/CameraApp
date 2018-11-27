//
//  ApplicationOpenUrlHandle.m
//  CameraApp
//
//  Created by aieffei on 2018/11/27.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "ApplicationOpenUrlHandle.h"

#import "ShareManager.h"

@implementation ApplicationOpenUrlHandle

+ (BOOL)handleOpenUrl:(NSURL *)url
{
    return [self handleOpenUrl:url sourceApplication:@"" annotation:@""];
}

+ (BOOL)handleOpenUrl:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    return [self handleOpenUrl:url sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey] annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
}

+ (BOOL)handleOpenUrl:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([ShareManager handleOpenUrl:url sourceApplication:sourceApplication annotation:annotation]) { //分享的回调
        return YES;
    } else {
        return NO;
    }
}
@end
