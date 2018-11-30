//
//  CameraHomeViewController+AuthorizationAndLayer.m
//  CameraApp
//
//  Created by aieffei on 2018/11/20.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CameraHomeViewController+AuthorizationAndLayer.h"
#import "ECAuthorizationTools.h"
#import "UIViewController+AlertViewAndActionSheet.h"
#import "CHBorderButton.h"

@implementation CameraHomeViewController (AuthorizationAndLayer)

- (void)getUserPhotoAuthorization
{
    [ECAuthorizationTools checkAndRequestAccessForType:ECPrivacyType_Camera accessStatus:^(ECAuthorizationStatus status, ECPrivacyType type) {
        
        //当用户拒绝授权且手机拥有该硬件的情况下，进行弹窗
        if (status == ECAuthorizationStatus_Denied && status != ECAuthorizationStatus_NotSupport) {
            [self AlertWithTitle:@"警告" message:@"您拒绝了App获取您的相机权限\n\n请前往设置-App-相机 开启" andOthers:@[@"前往设置"] animated:YES action:^(NSInteger index) {
                if (index == 0) {
                    [self proceedSettingUrl];
                }
            }];
        }
    }];
}

- (void)getUserPhotoLibraryAuthorization
{
    [ECAuthorizationTools checkAndRequestAccessForType:ECPrivacyType_Photos accessStatus:^(ECAuthorizationStatus status, ECPrivacyType type) {
        if (status == ECAuthorizationStatus_Denied && status != ECAuthorizationStatus_NotSupport) {
            [self AlertWithTitle:@"警告" message:@"您拒绝了App获取您的相机权限\n\n请前往设置-App-相册 开启" andOthers:@[@"前往设置"] animated:YES action:^(NSInteger index) {
            if (index == 0) {
                [self proceedSettingUrl];
            }
        }];
        }
    }];
}

//前往设置页面
- (void)proceedSettingUrl
{
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (void)mongolianLayer
{
    NSString *value = [NSString readUserDefaultWithKey:NSStringFromClass([self class])];
    if (!value) {
        //添加底部遮盖层
        UIView *coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.75];
        coverView.tag = 1000;
        [[coverView getKeyWindow] addSubview:coverView];
        
        CHBorderButton *getButton = [[CHBorderButton alloc] initWithFrame:CGRectMake(0, 300, 200, 50)];
        getButton.center = CGPointMake(CGRectGetWidth(coverView.bounds) / 2, CGRectGetHeight(coverView.bounds) / 2 + 200);
        [getButton setTitle:@"测试引导页面" forState:UIControlStateNormal];
        [getButton setTitleColor:HexColor(0xffffff) forState:UIControlStateNormal];
        getButton.borderColor = HexColor(0xffffff);
        getButton.borderWidth = 2;
        [getButton addTarget:self action:@selector(getNormalViewController:) forControlEvents:UIControlEventTouchUpInside];
        [coverView addSubview:getButton];
    }
}

- (void)getNormalViewController:(CHBorderButton *)btn
{
    [self removeUserDefaultWithKey:NSStringFromClass([self class])]; //测试用，可每次都执行
//    [@"1" writeUserDefaultWithKey:NSStringFromClass([self class])];
    UIView *view = [[self.view getKeyWindow] viewWithTag:1000];
    [view removeFromSuperview];
}

@end
