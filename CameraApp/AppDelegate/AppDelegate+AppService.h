//
//  AppDelegate+AppService.h
//  CameraApp
//
//  Created by aieffei on 2018/11/20.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * 包含第三方和应用内的业务逻辑，减轻入口处代码压力
 */
@interface AppDelegate (AppService)
/**
 * 单例
 */
+ (AppDelegate *)shareAppDelegate;
/**
 * 初始化服务
 */
- (void)initService;
/**
 * 初始化window
 */
- (void)initWindow;
/**
 * 当前顶层控制器
 */
- (UIViewController *)getCurrentVC;

- (UIViewController *)getCurrentUIVC;
@end

NS_ASSUME_NONNULL_END
