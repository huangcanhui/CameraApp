//
//  CHPhotoLibraryListViewController.h
//  CameraApp
//
//  Created by aieffei on 2018/11/22.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CHPhotoLibraryListViewController : UIViewController
/**
 * 页面回调
 */
@property (nonatomic, copy)void (^backCameraViewController)(void);
@end

NS_ASSUME_NONNULL_END
