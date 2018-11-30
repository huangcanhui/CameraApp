//
//  CHUtil.h
//  CameraApp
//
//  Created by aieffei on 2018/11/20.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CHUtil : NSObject
/**
 *  从配置文件中找出一个key对应的value值
 *  @param key 要查找的key值
 *  @return value值
 */
+ (NSString *)configFileValueWithKey:(NSString *)key ;

/**
 *  将一组配置写入配置文件
 *  @param key   key值
 *  @param value value值
 *  @return 是否写入成功
 */
+ (BOOL)writeToConfigFileWithKey:(NSString *)key andValue:(NSString *)value ;

@end


@interface CHUtil (Version)

+ (BOOL)isVersionString:(NSString *)version1 newerToString:(NSString *)another;

@end

NS_ASSUME_NONNULL_END
