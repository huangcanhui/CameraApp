//
//  CHTime.h
//  CameraApp
//
//  Created by aieffei on 2018/11/12.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CHTime : NSObject
/**
 * 获取当前时间
 */
+ (NSString *)getCurrentTimes;
/**
 * 获取时间戳(以秒为单位)
 */
+ (NSString *)getNowTimeTimestamp2;
/**
 * 获取时间戳(以毫秒为单位)
 */
+ (NSString *)getNowTimeTimestamp3;
/**
 * 获取当前的时间（yyyy-MM-dd HH:mm:ss）
 */
+ (NSString *)getTimeWithDateFormat;
/**
 * 将秒换成日期（以秒为单位）
 */
+ (NSString *)getDateWithSecond:(NSString *)second;
/**
 * 将日期换成时间戳
 */
+ (NSString *)timeSwitchTimestamp:(NSString *)dateString;
@end

NS_ASSUME_NONNULL_END
