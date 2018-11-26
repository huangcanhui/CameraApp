//
//  Personal.h
//  CameraApp
//
//  Created by aieffei on 2018/11/22.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Personal : NSObject
/**
 * 图片存储时间
 */
@property (nonatomic, strong)NSString *photoTime;
/**
 * 图片源
 */
@property (nonatomic, strong)NSData *photoData;
/**
 * 图片是否被删除
 */
@property (nonatomic, assign)BOOL isDelete;
/**
 * 分组ID
 */
@property (nonatomic, assign)NSInteger groupID;

@end

NS_ASSUME_NONNULL_END
