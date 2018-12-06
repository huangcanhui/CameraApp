//
//  SharedItem.h
//  CameraApp
//
//  Created by aieffei on 2018/12/6.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SharedItem : NSObject

- (instancetype)initWithData:(UIImage*)img andFile:(NSURL*)file;

@property (nonatomic, strong) UIImage *img;
@property (nonatomic, strong) NSURL *path;

@end

NS_ASSUME_NONNULL_END
