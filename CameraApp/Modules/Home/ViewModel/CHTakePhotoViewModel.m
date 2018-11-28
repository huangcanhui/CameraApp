//
//  CHTakePhotoViewModel.m
//  CameraApp
//
//  Created by aieffei on 2018/11/28.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CHTakePhotoViewModel.h"
#import "TipsModel.h"
#import <MJExtension.h>

@implementation CHTakePhotoViewModel

+ (NSArray *)takePhotoAdvanceWithPlist
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TipsSkill" ofType:@"plist"];
    NSArray *tempArray = [NSMutableArray arrayWithContentsOfFile:path];
     return [TipsModel mj_objectArrayWithKeyValuesArray:tempArray];
}

@end
