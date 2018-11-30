//
//  CHUtil.m
//  CameraApp
//
//  Created by aieffei on 2018/11/20.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CHUtil.h"

//配置文件名字
NSString * const ConfigFileName = @"config.strings" ;

@implementation CHUtil

+ (NSString *)configFileValueWithKey:(NSString *)key
{
    if (!key) {
        return nil ;
    }
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path = [NSString stringWithFormat:@"%@/%@",path,ConfigFileName] ;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path] == NO ) {
        NSError *error ;
        NSString *originFilePath = [[NSBundle mainBundle] pathForResource:ConfigFileName ofType:nil] ;
        [[NSFileManager defaultManager]copyItemAtPath:originFilePath toPath:path error:&error] ;
        NSLog(@"%@",error.localizedDescription);
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithContentsOfFile:path] ;
    NSAssert(dic, ([NSString stringWithFormat:@"复制config配置文件失败，请检查项目下是否有%@文件",ConfigFileName])) ;
    return dic[key];
}

+ (BOOL)writeToConfigFileWithKey:(NSString *)key andValue:(NSString *)value
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingPathComponent:ConfigFileName] ;
    
    
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc]initWithContentsOfFile:path] mutableCopy];
    if (!dic) {
        dic = [NSMutableDictionary dictionary];
    }
    dic[key] = value ;
    
    BOOL result = [dic writeToFile:path atomically:YES] ;
    
    return result;
    
}
@end


@implementation CHUtil (Version)

+ (BOOL)isVersionString:(NSString *)version newerToString:(NSString *)another
{
    if (!version) {
        version = @"0.0.0" ;
    }
    
    if (!another) {
        another = @"0.0.0" ;
    }
    
    NSMutableArray * array1 = [[version componentsSeparatedByString:@"."] mutableCopy];
    NSMutableArray * array2 = [[another componentsSeparatedByString:@"."] mutableCopy];
    
    if (array1.count <= array2.count) {
        NSInteger diff = array2.count - array1.count ;
        for (int i = 0 ; i < diff ; i ++ ) {
            [array1 addObject:@(0)] ;
        }
    }else{
        NSInteger diff = array1.count - array2.count ;
        for (int i = 0 ; i < diff ; i ++ ) {
            [array2 addObject:@"0"] ;
        }
    }
    
    //出错了.
    if (array1.count != array2.count)    return NO ;
    
    for (NSInteger i = 0 ; i < array1.count ; i ++ ) {
        NSInteger first  = [array1[i] integerValue] ;
        NSInteger second = [array2[i] integerValue] ;

        if (first != second) {
            return first > second ? YES : NO ;
        }
    }
    return NO ;
}

@end
