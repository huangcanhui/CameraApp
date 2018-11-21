//
//  CameraHomeViewController+AuthorizationAndLayer.h
//  CameraApp
//
//  Created by aieffei on 2018/11/20.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//
// 用户拍照权限和首页蒙层

#import "CameraHomeViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CameraHomeViewController (AuthorizationAndLayer)
/**
 * 获取用户的拍照权限
 */
- (void)getUserPhotoAuthorization;
/**
 * 获取用户的相册权限
 */
- (void)getUserPhotoLibraryAuthorization;
/**
 * 引导图
 */
- (void)mongolianLayer;

@end

NS_ASSUME_NONNULL_END
