//
//  PhotoLibraryReusableHeaderView.h
//  CameraApp
//
//  Created by aieffei on 2018/11/26.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Personal.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotoLibraryReusableHeaderView : UICollectionReusableView
/**
 * 数据源
 */
@property (nonatomic, strong)Personal *person;
/**
 * 图片数量
 */
@property (nonatomic, assign)NSInteger count;

@end

FOUNDATION_EXPORT NSString *const PhotoLibraryReusableHeaderViewIdentifier;

NS_ASSUME_NONNULL_END