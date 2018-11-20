//
//  AppDelegate+AppService.m
//  CameraApp
//
//  Created by aieffei on 2018/11/20.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "AppDelegate+AppService.h"
#import "CameraHomeViewController.h"

@implementation AppDelegate (AppService)

+ (AppDelegate *)shareAppDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)initService
{
    //监听用户体系
    
    //监听网络状态
}

- (void)initWindow
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    CameraHomeViewController *vc = [CameraHomeViewController new];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
}

@end
