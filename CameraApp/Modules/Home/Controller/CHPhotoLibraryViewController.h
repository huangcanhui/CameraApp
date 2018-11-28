//
//  CHPhotoLibraryViewController.h
//  CameraApp
//
//  Created by aieffei on 2018/11/20.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, enterType) {
    enterTypeOnCamera = 0 , //通过相机页面进入
    enterTypeOnPhotoLibrary , //通过图库进入
};

@interface CHPhotoLibraryViewController : UIViewController
/**
 * 进入页面的方式
 */
@property (nonatomic, assign)enterType type;
/**
 * 进入时携带的时间
 */
@property (nonatomic, copy)NSString *moment;
/**
 * 回调,刷新上一个页面
 */
@property (nonatomic, copy)void (^reloadViewController)(void);
@end

NS_ASSUME_NONNULL_END
