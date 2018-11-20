//
//  ApiMacros.h
//  CameraApp
//
//  Created by aieffei on 2018/11/7.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#ifndef ApiMacros_h
#define ApiMacros_h

//#define SERVER_URL @""
#ifdef DEBUG    //---- Debug模式下
#define SERVER_URL ([CHUtil configFileValueWithKey:@"Dev_Url"])
#else           //---- Release版本
#define SERVER_URL @"https://sdfj/sdfsdf"
#endif

#endif /* ApiMacros_h */
