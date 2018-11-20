//
//  CHProgressHUD.h
//  CameraApp
//
//  Created by aieffei on 2018/11/7.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "MBProgressHUD.h"

typedef NS_ENUM(NSInteger, CHProgressHUDStatus) {
    //成功
    CHProgressHUDStatusSuccess = 0,
    //失败
    CHProgressHUDStatusFaiule,
    //等待
    CHProgressHUDStatusLoading,
    //警告
    CHProgressHUDStatusWarning,
    //提示
    CHProgressHUDStatusCue,
};

NS_ASSUME_NONNULL_BEGIN

@interface CHProgressHUD : MBProgressHUD
/**
 * 是否正在显示
 */
@property (nonatomic, assign, getter=isShowNow)BOOL showNow;
/**
 * 返回一个HUD的单例
 */
+ (instancetype)sharedHUD;
/**
 * 在Windows上添加一个HUD
 */
+ (void)showStatus:(CHProgressHUDStatus)status text:(NSString *)text;
/**
 * 添加一个只显示文字的HUD
 */
+ (void)showMessage:(NSString *)message;
/**
 * 添加一个提示的HUD
 */
+ (void)showInfo:(NSString *)info;
/**
 * 添加一个成功的HUD
 */
+ (void)showSuccess:(NSString *)success;
/**
 * 添加一个失败的HUD
 */
+ (void)showFaile:(NSString *)faile;
/**
 * 添加一个小菊花（需要手动进行关闭）
 */
+ (void)showLoading:(NSString *)loading;
/**
 * 隐藏HUD
 */
+ (void)hideHUD;

@end

NS_ASSUME_NONNULL_END
