//
//  CHBrowserBottomView.h
//  CameraApp
//
//  Created by aieffei on 2018/11/23.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CHBrowserBottomView : UIView
/**
 * 删除按钮的回调
 */
@property (nonatomic, copy)void (^PhotoBrowserDeleteButtonClick)(UIButton *btn);
/**
 * 分享按钮的回调
 */
@property (nonatomic, copy)void (^PhotoBrowserShareButtonClick)(UIButton *btn);
@end

NS_ASSUME_NONNULL_END
