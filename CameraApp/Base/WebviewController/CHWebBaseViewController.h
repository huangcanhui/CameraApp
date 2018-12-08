//
//  CHWebBaseViewController.h
//  CameraApp
//
//  Created by aieffei on 2018/11/30.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CHWebViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CHWebBaseViewController : CHWebViewController
/**
 * 在多级跳转后，是否返回按钮右侧展示关闭按钮
 */
@property (nonatomic, assign)BOOL isShowCloseBtn;

@end

NS_ASSUME_NONNULL_END
