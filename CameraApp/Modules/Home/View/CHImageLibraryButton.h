//
//  CHImageLibraryButton.h
//  CameraApp
//
//  Created by aieffei on 2018/11/22.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CHImageLibraryButton;

typedef void(^myBlock)(CHImageLibraryButton *button);

@interface CHImageLibraryButton : UIButton
/**
 * 点击时间的回调
 */
@property (nonatomic, copy)myBlock block;
/**
 * 图片数据
 */
@property (nonatomic, strong)NSData *imageData;

+ (CHImageLibraryButton *)buttonWithFrame:(CGRect)frame type:(UIButtonType)type andBlock:(myBlock)block;

@end

NS_ASSUME_NONNULL_END
