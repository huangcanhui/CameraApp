//
//  PhotoTakeTimeMath.h
//  CameraApp
//
//  Created by aieffei on 2018/11/24.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//
/********************* 这是用来计算图片之间的间隔并进行分组 ***************************/

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoTakeTimeMath : NSObject
/**
 * 将数组拆分，分组
 */
- (NSArray *)arrayComponentToObjectAndSoryBYTime:(NSArray *)dataSource;
/**
 * 获取主标题
 */
- (NSString *)titleShowString:(NSString *)pictime;
/**
 *获取副标题
 */
- (NSString *)subTitleWithTimestamp:(NSString *)time;

@end

NS_ASSUME_NONNULL_END
