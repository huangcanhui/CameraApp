//
//  CHProgressHUD.m
//  CameraApp
//
//  Created by aieffei on 2018/11/7.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CHProgressHUD.h"

//背景视图的宽/高
#define BGView_Width 100.f
//文字的大小
#define Text_Size 16.0f

@implementation CHProgressHUD

+ (instancetype)sharedHUD
{
    static id hud;
    static dispatch_once_t oncetoken;
    dispatch_once(&oncetoken, ^{
        hud = [[self alloc] initWithView:[UIApplication sharedApplication].keyWindow];
    });
    return hud;
}

+ (void)showStatus:(CHProgressHUDStatus)status text:(NSString *)text
{
    CHProgressHUD *hud = [CHProgressHUD sharedHUD];
    hud.bezelView.color = HexColor(0x000000);
    hud.contentColor = HexColor(0xffffff);
    [hud showAnimated:YES];
    [hud setShowNow:YES];
//    //蒙版显示 yes显示 no不显示
//    hud.dimBackground = NO;
    hud.label.text = text;
    hud.label.textColor = HexColor(0xffffff);
    [hud setRemoveFromSuperViewOnHide:YES];
    hud.label.font = [UIFont boldSystemFontOfSize:Text_Size];
    [hud setMinSize:CGSizeMake(BGView_Width, BGView_Width)];
    NSLog(@"%f", BGView_Width);
    [[UIApplication sharedApplication].keyWindow addSubview:hud];
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CHProgressHUD" ofType:@"bundle"];
    
    switch (status) {
        case CHProgressHUDStatusSuccess:
        {
            NSString *successPath = [bundlePath stringByAppendingPathComponent:@"MBHUD_Success.png"];
            UIImage *successImage = [UIImage imageWithContentsOfFile:successPath];
            hud.mode = MBProgressHUDModeCustomView;
            UIImageView *successImageView = [[UIImageView alloc] initWithImage:successImage];
            hud.customView = successImageView;
            [hud hideAnimated:YES afterDelay:2.0];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud setShowNow:NO];
            });
        }
            break;
        
        case CHProgressHUDStatusFaiule:
        {
            NSString *failePath = [bundlePath stringByAppendingPathComponent:@"MBHUD_Error.png"];
            UIImage *faileImage = [UIImage imageWithContentsOfFile:failePath];
            hud.mode = MBProgressHUDModeCustomView;
            UIImageView *faileImageView = [[UIImageView alloc] initWithImage:faileImage];
            hud.customView = faileImageView;
            [hud hideAnimated:YES afterDelay:2.0];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud setShowNow:NO];
            });
        }
            break;
            
        case CHProgressHUDStatusLoading:
            hud.mode = MBProgressHUDModeIndeterminate;
            break;
            
        case CHProgressHUDStatusCue:
        {
            NSString *infoPath = [bundlePath stringByAppendingPathComponent:@"MBHUD_Info@2x.png"];
            UIImage *infoImage = [UIImage imageWithContentsOfFile:infoPath];
            hud.mode = MBProgressHUDModeCustomView;
            UIImageView *infoImageView = [[UIImageView alloc] initWithImage:infoImage];
            hud.customView = infoImageView;
            [hud hideAnimated:YES afterDelay:2.0];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud setShowNow:NO];
            });
        }

            break;
            
        case CHProgressHUDStatusWarning:
        {
            NSString *warnPath = [bundlePath stringByAppendingPathComponent:@"MBHUD_Warn.png"];
            UIImage *warnImage = [UIImage imageWithContentsOfFile:warnPath];
            hud.mode = MBProgressHUDModeCustomView;
            UIImageView *warnImageView = [[UIImageView alloc] initWithImage:warnImage];
            hud.customView = warnImageView;
            [hud hideAnimated:YES afterDelay:2.0];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud setShowNow:NO];
            });
        }
            break;
        
            
        default:
            break;
    }
    
    
}

+ (void)showMessage:(NSString *)message
{
    CHProgressHUD *hud = [CHProgressHUD sharedHUD];
    hud.bezelView.color = HexColor(0x000000);
    hud.contentColor = HexColor(0xffffff);
    [hud showAnimated:YES];
    [hud setShowNow:YES];
    //    //蒙版显示 yes显示 no不显示
    //    hud.dimBackground = NO;
    hud.label.text = message;
    hud.label.textColor = HexColor(0xffffff);
    [hud setRemoveFromSuperViewOnHide:YES];
    hud.label.font = [UIFont boldSystemFontOfSize:Text_Size];
    [hud setMinSize:CGSizeMake(BGView_Width, BGView_Width)];
    [[UIApplication sharedApplication].keyWindow addSubview:hud];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[CHProgressHUD sharedHUD] setShowNow:NO];
        [[CHProgressHUD sharedHUD] hideAnimated:YES];
    });
}

+ (void)showSuccess:(NSString *)success
{
    [self showStatus:CHProgressHUDStatusSuccess text:success];
}

+ (void)showFaile:(NSString *)faile
{
    [self showStatus:CHProgressHUDStatusFaiule text:faile];
}

+ (void)showInfo:(NSString *)info
{
    [self showStatus:CHProgressHUDStatusCue text:info];
}

+ (void)showLoading:(NSString *)loading
{
    [self showStatus:CHProgressHUDStatusLoading text:loading];
}

+ (void)hideHUD
{
    [[CHProgressHUD sharedHUD] setShowNow:NO];
    [[CHProgressHUD sharedHUD] hideAnimated:YES];
}

@end
