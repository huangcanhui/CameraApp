//
//  CHSpringView.h
//  CameraApp
//
//  Created by aieffei on 2018/11/21.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CameraStatus) {
    cameraStatusHightLight = 0, //可以拍照状态
    cameraStatusNormal , //不可以拍照状态
};

NS_ASSUME_NONNULL_BEGIN

@interface CHSpringView : UIView

- (void)getGravityX:(double)x gravityY:(double)y gravity:(double)z;
/**
 * 按钮状态的回调
 */
@property (nonatomic, copy)void (^getAngleToChangeCameraButtonStatus)(CameraStatus status);

@end

NS_ASSUME_NONNULL_END
