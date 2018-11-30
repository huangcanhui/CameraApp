//
//  PhotoTakeTimeMath.m
//  CameraApp
//
//  Created by aieffei on 2018/11/24.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "PhotoTakeTimeMath.h"
#import "Personal.h"
#import "CHTime.h"

//static float Times = 600; //间隔

@implementation PhotoTakeTimeMath

- (NSArray *)arrayComponentToObjectAndSoryBYTime:(NSArray *)dataSource
{
    NSArray *array = [NSArray array];
    array = [self filterMaxItemsArray:dataSource isStringObj:NO filterKey:@"groupID"];
    return array;
}

- (NSArray *)filterMaxItemsArray:(NSArray *)array isStringObj:(BOOL)isString filterKey:(NSString *)key {
   
    NSMutableArray *LessonArr=[NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(Personal *obj, NSUInteger idx, BOOL *stop) {
        NSString *LessonID= [NSString stringWithFormat:@"%ld", obj.groupID];//根据分组ID进行区分
        [LessonArr addObject:LessonID];
    }];
    
    //使用asset把LessonArr的对象去重
    NSSet *set = [NSSet setWithArray:LessonArr];
    NSArray *userArray = [set allObjects];
    NSSortDescriptor *sd1 = [NSSortDescriptor sortDescriptorWithKey:nil ascending:NO];//yes升序排列，no,降序排列
    //按ID降序排列的数
    NSArray *myary = [userArray sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sd1, nil]];
    //此时得到的myary就是按照ID   降序排列拍好的数组
    NSMutableArray *titleArray=[NSMutableArray array];
    
    //遍历myary把_titleArray按照myary里的时间分成几个组每个组都是空的数组
    [myary enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray *arr=[NSMutableArray array];
        [titleArray addObject:arr];
    }];
    
    //遍历_dataArray取其中每个数据的ID看看与myary里的那个ID匹配就把这个数据装到_titleArray 对应的组中
    [array enumerateObjectsUsingBlock:^(Personal *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *LessonID = [NSString stringWithFormat:@"%ld", obj.groupID];
        for (NSString *str in myary)
        {
            if([str integerValue] ==[LessonID integerValue])//检测ID是否是一样的
            {
                NSMutableArray *arr=[titleArray objectAtIndex:[myary indexOfObject:str]];
                [arr addObject:obj];//是的话就添加到数组里面
            }
        }
    }];
    
    return titleArray;
}


//获取主标题
- (NSString *)titleShowString:(NSString *)pictime
{
    NSString *currentTime = [CHTime getTimeWithDateFormat];
    NSArray *array = [currentTime componentsSeparatedByString:@" "];
    NSString *newTime = [NSString stringWithFormat:@"%@ 23:59:59", array[0]]; //今天最后一秒的时间戳
    
    NSString *todayTimesStamp = [CHTime timeSwitchTimestamp:newTime]; //今天
    float plus = [todayTimesStamp floatValue] - [pictime floatValue];

//    float yesterdayTimeStamp = [todayTimesStamp floatValue] - 24 * 60 * 60; //昨天
//    float beforeYesterdayTimeStamp = [todayTimesStamp floatValue] - 2 * 24 * 60 * 60; //前天
    if (plus < 24 * 60 * 60) { //显示今天
        return @"今天";
    } else if (plus < 24 * 60 * 60 * 2) { //昨天
        return @"昨天";
    } else if (plus < 24 * 60 * 60 * 3) { //前天
        return @"前天";
    } else {
       NSString *oldTime = [CHTime getDateWithSecond:pictime];
        NSArray *array = [oldTime componentsSeparatedByString:@" "];
        return array[0];
    }
    return nil;
}

//获取副标题
- (NSString *)subTitleWithTimestamp:(NSString *)time
{
    NSString *dateTime = [CHTime getDateWithSecond:time];
    
    NSArray *dateArray = [dateTime componentsSeparatedByString:@" "];
    
    NSArray *timsArray = [dateArray[1] componentsSeparatedByString:@":"];
    
    return [NSString stringWithFormat:@"%@:%@", timsArray[0], timsArray[1]];
}

@end
