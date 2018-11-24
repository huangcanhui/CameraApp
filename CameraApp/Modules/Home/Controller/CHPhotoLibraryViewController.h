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
 * 数据源
 */
@property (nonatomic, strong)NSData *imageData;
@end

NS_ASSUME_NONNULL_END
