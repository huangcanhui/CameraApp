//
//  PhotoListCollectionViewCell.h
//  CameraApp
//
//  Created by aieffei on 2018/11/27.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Personal.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotoListCollectionViewCell : UICollectionViewCell
/**
 * 数据源
 */
@property (nonatomic, strong)Personal *person;
/**
 * 是否被选中
 */
@property (nonatomic, assign)BOOL isSelect;

@end

NS_ASSUME_NONNULL_END
