//
//  CHWebViewController.h
//  CameraApp
//
//  Created by aieffei on 2018/11/30.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "CHRootViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CHWebViewController : CHRootViewController
/**
 * 网页视图
 */
@property (nonatomic, strong)WKWebView *webView;
/**
 * 进度视图
 */
@property (nonatomic, strong)UIProgressView *progressView;
/**
 * 进度条颜色
 */
@property (nonatomic)UIColor *progressViewColor;
/**
 * 网页代理
 */
@property (nonatomic, weak)WKWebViewConfiguration *webConfiguration;
/**
 * 网页地址
 */
@property (nonatomic, copy)NSString *url;

- (instancetype)initWithUrl:(NSString *)url;
/**
 * 更新进度条
 */
- (void)updateProgress:(double)progress;
/**
 * 更新导航栏按钮，子类去实现
 */
- (void)updateNavigationItems;

@end

NS_ASSUME_NONNULL_END
