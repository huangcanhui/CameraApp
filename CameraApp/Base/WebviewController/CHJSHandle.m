//
//  CHJSHandle.m
//  CameraApp
//
//  Created by aieffei on 2018/11/30.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CHJSHandle.h"

@interface CHJSHandle ()<WKScriptMessageHandler>

@end

@implementation CHJSHandle

- (instancetype)initWithViewController:(UIViewController *)webVC configuration:(WKWebViewConfiguration *)configuration
{
    if (self = [super init]) {
        _webVC = webVC;
        _configuration = configuration;
        //注册JS事件
        [configuration.userContentController addScriptMessageHandler:self name:@"backPage"];
    }
    return self;
}

#pragma mark - js调用native代理
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    if ([message.name isEqualToString:@"backPage"]) {
        if (self.webVC.presentingViewController) {
            [self.webVC dismissViewControllerAnimated:YES completion:nil];
        } else {
            [self.webVC.navigationController popViewControllerAnimated:YES];
        }
    }
}

#pragma mark - 移除
- (void)cancelHandler
{
    [_configuration.userContentController removeScriptMessageHandlerForName:@"backPage"];
}


@end
