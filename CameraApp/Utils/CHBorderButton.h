//
//  CHBorderButton.h
//  CameraApp
//
//  Created by aieffei on 2018/11/29.
//  Copyright © 2018年 黄灿辉. All rights reserved.
/*****************   自定义的边框宽度和颜色     ************************/

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CHBorderButton : UIButton
/**
 *  边框颜色
 */
@property (nonatomic, strong)UIColor *borderColor ;
/**
 *  边框宽度
 */
@property (nonatomic, assign)CGFloat borderWidth ;

@end

NS_ASSUME_NONNULL_END
