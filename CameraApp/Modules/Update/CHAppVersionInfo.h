//
//  CHAppVersionInfo.h
//  CameraApp
//
//  Created by aieffei on 2018/11/30.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CHAppVersionInfo : NSObject
/**
 * 本地的版本
 */
@property (nonatomic, copy, readonly)NSString *local_app_version;
@property (nonatomic, copy, readonly)NSString *local_app_build_version;
/**
 * 服务器的最后一个版本
 */
@property (nonatomic, copy)NSString *server_latest_app_version;
/**
 * 下载地址
 */
@property (nonatomic, copy)NSString *download_url;
/**
 * 更新的内容
 */
@property (nonatomic, copy)NSString *upgrade_content;
/**
 * 是否需要强制更新
 */
@property (nonatomic, assign)BOOL need_force_uodate;

/**
 * 默认从缓存中加载
 * @return 之前存储的APPVersioninfo的对象
 */
+ (instancetype)defaultVersionInfo;
/**
 * 保存当前对象为版本的信息实例
 */
- (void)savedAsDefault;

@end

NS_ASSUME_NONNULL_END
