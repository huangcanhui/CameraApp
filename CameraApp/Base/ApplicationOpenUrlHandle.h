//
//  ApplicationOpenUrlHandle.h
//  CameraApp
//
//  Created by aieffei on 2018/11/27.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//
/****************************** 统一处理Apph与外界的回调 *******************************************/
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ApplicationOpenUrlHandle : NSObject

+ (BOOL)handleOpenUrl:(NSURL *)url ;

+ (BOOL)handleOpenUrl:(NSURL *)url
              options:(NSDictionary<NSString *,id> *)options ;

+ (BOOL)handleOpenUrl:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation ;

@end

NS_ASSUME_NONNULL_END
