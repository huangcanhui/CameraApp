//
//  CHADPageView.h
//  CameraApp
//
//  Created by aieffei on 2018/11/30.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * 启动广告页面
 */
static NSString *const adImageName = @"adImageName";
static NSString *const adUrl = @"adUrl";
/**
 * 点击事件的回调
 */
typedef void(^tapBlock)(void);

@interface CHADPageView : UIView

- (instancetype)initWithFrame:(CGRect)frame withTapBlock:(tapBlock)tapBlock;
/**
 * 显示广告页面方法
 */
- (void)show;
/**
 * 图片路径
 */
@property (nonatomic, copy)NSString *filePath;

@end

NS_ASSUME_NONNULL_END
