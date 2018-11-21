//
//  SystemsMacros.h
//  CameraApp
//
//  Created by aieffei on 2018/11/7.
//  Copyright © 2018年 黄灿辉. All rights reserved.
// 系统宏

#ifndef SystemsMacros_h
#define SystemsMacros_h

//十六进制的颜色值
#define HexColor(rgbValue) ([UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0])

//设置全局主要颜色
#define GLOBAL_COLOR HexColor(0x000000)
//三个主要颜色
#define KClearColor [UIColor clearColor]
#define KWhiteColor [UIColor whiteColor]
#define KBlackColor [UIColor blackColor]

//宽、高
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//头部的高度
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
#define kTopHeight (kStatusBarHeight + kNavBarHeight)

//tabbar的高度
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)

//根据ip6的屏幕来拉伸
#define kRealValue(with) ((with)*(KScreenWidth/375.0f))

//强、弱指针的引用
#define weakSelf(wself) __typeof(*&self) __weak wself = self
#define strongSelf(wself,sself) __typeof(*&wself) __strong sself = wself ;

#endif /* SystemsMacros_h */
