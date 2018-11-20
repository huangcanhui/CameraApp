//
//  Debug_DevelopmentModel.h
//  CameraApp
//
//  Created by aieffei on 2018/11/20.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Debug_DevelopmentModel : NSObject
/**
 * 环境名
 */
@property (nonatomic, copy)NSString *name;
/**
 * 网址
 */
@property (nonatomic, copy)NSString *url;
/**
 初始化一个开发环境
 */
- (instancetype)initWithDictionary:(NSDictionary *)dic ;

@end

NS_ASSUME_NONNULL_END
