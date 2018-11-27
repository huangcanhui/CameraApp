//
//  ShareManager.m
//  CameraApp
//
//  Created by aieffei on 2018/11/27.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "ShareManager.h"

@implementation ShareManager

+ (instancetype)shareInstance
{
    static ShareManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
        [WXApi registerApp:wechatAppID];
    });
    return manager;
}

+ (BOOL)handleOpenUrl:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WXApi handleOpenURL:url delegate:self];
}

+ (BOOL)handleOpenUrl:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}

- (void)shareContentType:(shareType)type content:(NSString *)content imageArray:(NSArray *)imageArray
{
//    if (type == shareTypeInSession) { //分享到好友
//
//    }
    WXMediaMessage *message = [WXMediaMessage message];
    WXImageObject *object = [WXImageObject object];
    
}

- (void)onReq:(BaseReq *)req
{
    
}

- (void)onResp:(BaseResp *)resp
{
    
}

@end
