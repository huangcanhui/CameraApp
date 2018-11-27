//
//  CHBrowserBottomView.h
//  CameraApp
//
//  Created by aieffei on 2018/11/23.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHBottomButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface CHBrowserBottomView : UIView
/**
 * 删除按钮的回调
 */
@property (nonatomic, copy)void (^PhotoBrowserDeleteButtonClick)(CHBottomButton *btn);
/**
 * 分享微信聊天页面的回调
 */
@property (nonatomic, copy)void (^PhotoBrowserShareSessionButtonClick)(CHBottomButton *btn);
/**
 * 分享微信朋友圈页面的回调
 */
@property (nonatomic, copy)void (^PhotoBrowserShareTimeLineButtonClick)(CHBottomButton *btn);

@end

NS_ASSUME_NONNULL_END
