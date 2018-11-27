//
//  CHBottomButton.m
//  CameraApp
//
//  Created by aieffei on 2018/11/27.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CHBottomButton.h"

@implementation CHBottomButton

#pragma mark - 设置button内部图片的位置
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.height * 0.48;
    CGFloat imageH = contentRect.size.height * 0.48;
    CGFloat X = contentRect.size.width * 0.4;
    CGFloat Y = contentRect.size.height * 0.1;
    return CGRectMake(X, Y, imageW, imageH);
}

#pragma mark - 设置title的位置
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat X = contentRect.size.width * 0.15;
    CGFloat Y = contentRect.size.height * 0.7;
    CGFloat labelW = contentRect.size.width * 0.7;
    CGFloat labelH = contentRect.size.height * 0.2;
    return CGRectMake(X, Y, labelW, labelH);
}

@end
