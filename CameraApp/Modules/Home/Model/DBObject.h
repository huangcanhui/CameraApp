//
//  DBObject.h
//  CameraApp
//
//  Created by aieffei on 2018/11/21.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DBObject : NSObject
/**
 * ID, 主键
 */
@property (nonatomic, assign)NSInteger pkid;
/**
 * 时间戳
 */
@property (nonatomic, strong)NSString *photoTime;
/**
 * value
 */
@property (nonatomic, strong)NSData *photoData;
/**
 * 是否删除
 */
@property (nonatomic, assign)BOOL isDelete;

@end

NS_ASSUME_NONNULL_END
