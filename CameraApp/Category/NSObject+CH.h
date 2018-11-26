//
//  NSObject+CH.h
//  CameraApp
//
//  Created by aieffei on 2018/11/26.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (CH)
- (void)reload;
/*
 *将一个对象写入userDefault
 **/
- (void)writeUserDefaultWithKey:(NSString *)key;
/*
 * 将一个对象从UserDefault中读出
 **/
+ (id)readUserDefaultWithKey:(NSString *)key;
/*
 * 将一个对象从UserDefault中删除
 **/
- (void)removeUserDefaultWithKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
