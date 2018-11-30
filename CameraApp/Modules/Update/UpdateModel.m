//
//  UpdateModel.m
//  CameraApp
//
//  Created by aieffei on 2018/11/30.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "UpdateModel.h"

#import "CHAppVersionInfo.h"

@implementation UpdateModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"content":@"description"
             };
}

+ (void)abtain_update_info
{
    //在这边进行网络请求
}

//保存信息
+ (void)saveInfo:(UpdateModel *)info
{
    CHAppVersionInfo *version = [[CHAppVersionInfo alloc] init];
    version.upgrade_content = info.content;
    version.need_force_uodate = info.need_force_update;
    if (info.Url && info.Url.length > 0) {
        version.download_url = info.Url;
    }
    version.server_latest_app_version= info.version;
    [version savedAsDefault];
}

@end
