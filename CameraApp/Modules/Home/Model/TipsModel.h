//
//  TipsModel.h
//  CameraApp
//
//  Created by aieffei on 2018/11/28.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TipsModel : NSObject
/**
 * 是否展示错误的图片
 */
@property (nonatomic, assign)BOOL showfalse;
/**
 * 标题
 */
@property (nonatomic, copy)NSString *title;
/**
 * 描述
 */
@property (nonatomic, copy)NSString *memo;
/**
 * 图片
 */
@property (nonatomic, strong)NSArray *photo;

@end

NS_ASSUME_NONNULL_END
