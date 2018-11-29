//
//  UIView+CH.h
//  CameraApp
//
//  Created by aieffei on 2018/11/20.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CH)
/**
 * view的4个方位的快捷获取和修改方法
 */
@property (nonatomic, assign) CGFloat ch_height ;
@property (nonatomic, assign) CGFloat ch_width ;
@property (nonatomic, assign) CGFloat ch_left ;
@property (nonatomic, assign) CGFloat ch_right ;
@property (nonatomic, assign) CGFloat ch_top ;
@property (nonatomic, assign) CGFloat ch_bottom ;

/**----------------------------------------*/
- (UIWindow *)getKeyWindow ;
+ (UIWindow *)getKeyWindow ;

@end

NS_ASSUME_NONNULL_END
