//
//  AFNetManager.h
//  Cybespoke
//
//  Created by pengpeng on 15/10/8.
//  Copyright © 2015年 pengpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "User.h"

@interface AFNetManager : NSObject
 
+ (void)uploadUserData:(User *)user success:(void (^)(id))success fail:(void (^)(NSError *))fail;

@end
