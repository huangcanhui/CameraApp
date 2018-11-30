//
//  UpdateModel.h
//  CameraApp
//
//  Created by aieffei on 2018/11/30.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//
/***************************** 更新信息的实体类 *************************************************/

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UpdateModel : NSObject
/**
 * 新版本号
 */
@property (nonatomic, copy)NSString *version;
/**
 * 下载的地址
 */
@property (nonatomic, copy)NSString *Url;
/**
 * 新版本的内容描述
 */
@property (nonatomic, copy)NSString *content;
/**
 * 是否需要强制更新
 */
@property (nonatomic, assign)BOOL need_force_update;
/**
 * 获取更新信息
 */
+ (void)abtain_update_info;

@end

NS_ASSUME_NONNULL_END
