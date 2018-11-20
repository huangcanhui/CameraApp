//
//  SystemsMacros.h
//  CameraApp
//
//  Created by aieffei on 2018/11/7.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#ifndef SystemsMacros_h
#define SystemsMacros_h
//十六进制的颜色值
#define HexColor(rgbValue) ([UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0])

#endif /* SystemsMacros_h */
