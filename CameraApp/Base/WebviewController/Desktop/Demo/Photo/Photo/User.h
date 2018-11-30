//
//  AFNetManager.m
//  Cybespoke
//
//  Created by pengpeng on 15/10/8.
//  Copyright © 2015年 pengpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

//base info
@property(nonatomic, copy) NSString *ID;
@property(nonatomic, copy) NSString *userName;
@property(nonatomic, assign) NSInteger height;
@property(nonatomic, assign) float weight;
@property(nonatomic, copy) NSString *phoneNum;

@property(nonatomic, assign) BOOL state;

//picuture path
@property(nonatomic, copy) NSString *frontPath;
@property(nonatomic, copy) NSString *sidePath;
@property(nonatomic, copy) NSString *backgroundPath;

@property(nonatomic, copy) NSDate *createTime;

-(instancetype)init;
-(instancetype)initFromDict:(NSDictionary *)dict;
-(NSDictionary *)convertToDict;

@end
