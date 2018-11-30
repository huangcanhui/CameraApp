//
//  AppDelegate+AppService.m
//  CameraApp
//
//  Created by aieffei on 2018/11/20.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "AppDelegate+AppService.h"

#import "CameraHomeViewController.h"
#import "ApplicationOpenUrlHandle.h"
#import "CHADPageView.h"
#import "CHNavigationController.h"
#import "CHWebBaseViewController.h"

#import <MTA.h>
#import <MTAConfig.h>

@implementation AppDelegate (AppService)

+ (AppDelegate *)shareAppDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)initService
{
    //监听用户体系
    
    //监听网络状态
    
   //用户统计
    [self startTencentMTA];
}

#pragma mark - 启动腾讯统计
- (void)startTencentMTA
{
    [MTA startWithAppkey:MTAKey];
    //查看mta的工作
    [[MTAConfig getInstance] setDebugEnable:YES];
    
}

- (void)initWindow
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    CameraHomeViewController *vc = [CameraHomeViewController new];
    CHNavigationController *naVC = [[CHNavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = naVC;
    [self.window makeKeyAndVisible];
    
    //开辟线程，防止阻塞主线程
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self checkAppUpdate];
    });
}

#pragma mark - 检测App是否需要更新
- (void)checkAppUpdate
{
    
}

#pragma mark - 是否展示广告
- (void)showADPageView
{
    CHADPageView *adView = [[CHADPageView alloc] initWithFrame:[UIScreen mainScreen].bounds withTapBlock:^{
        CHNavigationController *naviVC = [[CHNavigationController alloc] initWithRootViewController:[[CHWebBaseViewController alloc] initWithUrl:@"http://www.baidu.com"]];
        [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:naviVC animated:YES completion:nil];
    }];
    adView = adView;
}

- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
    {
        result = nextResponder;
    } else {
        result = window.rootViewController;
    }
    return result;
}

-(UIViewController *)getCurrentUIVC
{
    UIViewController  *superVC = [self getCurrentVC];
    
    if ([superVC isKindOfClass:[UITabBarController class]]) {
        
        UIViewController  *tabSelectVC = ((UITabBarController*)superVC).selectedViewController;
        
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)tabSelectVC).viewControllers.lastObject;
        }
        return tabSelectVC;
    } else
        if ([superVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)superVC).viewControllers.lastObject;
        }
    return superVC;
}

/**
 * iOS 9以上调用的方法
 */
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    return [ApplicationOpenUrlHandle handleOpenUrl:url options:options];
}

@end
