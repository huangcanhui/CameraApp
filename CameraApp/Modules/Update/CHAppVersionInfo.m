//
//  CHAppVersionInfo.m
//  CameraApp
//
//  Created by aieffei on 2018/11/30.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CHAppVersionInfo.h"
#import <MJExtension.h>

//App的App Store下载地址
NSString *const MeifangCameraAppStoreDownloadUrl = @"";
static NSString *const CHAppVersionInfoSaveKey = @"CHAppVersionInfoSaveKey";

@implementation CHAppVersionInfo

- (instancetype)init
{
    if (self = [super init]) {
        NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
        _local_app_version = info[@"CFBundleShortVersionString"];
        _local_app_build_version = info[(__bridge NSString *) kCFBundleVersionKey];
        _need_force_uodate = NO;
        _download_url = MeifangCameraAppStoreDownloadUrl;
        _upgrade_content = @"";
    }
    return self;
}

+ (instancetype)defaultVersionInfo
{
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:CHAppVersionInfoSaveKey];
    CHAppVersionInfo *info = [CHAppVersionInfo mj_objectWithKeyValues:dic];
    return info;
}

- (void)savedAsDefault
{
    NSDictionary *dic = [self mj_JSONObject];
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:CHAppVersionInfoSaveKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
