//
//  CHJSHandle.h
//  CameraApp
//
//  Created by aieffei on 2018/11/30.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//
/************************  处理各种js交互 ******************************************/

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CHJSHandle : NSObject

@property (nonatomic, weak, readonly)UIViewController *webVC;
@property (nonatomic, strong, readonly)WKWebViewConfiguration *configuration;

- (instancetype)initWithViewController:(UIViewController *)webVC configuration:(WKWebViewConfiguration *)configuration;

- (void)cancelHandler;

@end

NS_ASSUME_NONNULL_END
