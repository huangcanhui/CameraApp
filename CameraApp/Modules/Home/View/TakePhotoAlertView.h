//
//  TakePhotoAlertView.h
//  CameraApp
//
//  Created by aieffei on 2018/11/29.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TakePhotoAlertView : UIView
/**
 * 获取水平仪的值
 */
- (void)getGravityX:(double)x gravityY:(double)y gravity:(double)z;
@end

NS_ASSUME_NONNULL_END
