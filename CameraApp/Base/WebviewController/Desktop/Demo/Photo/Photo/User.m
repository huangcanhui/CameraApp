//
//  AFNetManager.m
//  Cybespoke
//
//  Created by pengpeng on 15/10/8.
//  Copyright © 2015年 pengpeng. All rights reserved.
//

#import "User.h"

@implementation User

-(instancetype)init
{
    self = [super init];
    if (self) {
        _ID = [[NSUUID UUID] UUIDString];
        _createTime = [NSDate date];
    }
    return self;
}

-(instancetype)initFromDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        _ID         = [dict objectForKey:@"ID"];
        _createTime = [dict objectForKey:@"createTime"];
        
        _userName   = [dict objectForKey:@"userName"];
        _height     = [[dict objectForKey:@"height"] integerValue];
        _weight     = [[dict objectForKey:@"weight"] floatValue];
        _phoneNum   = [dict objectForKey:@"phoneNum"];
        
        _state      = [[dict objectForKey:@"state"] boolValue];
        
        _frontPath  = [dict objectForKey:@"frontPath"];
        _sidePath   = [dict objectForKey:@"sidePath"];
        _backgroundPath = [dict objectForKey:@"backgroundPath"];
    }
    return  self;
}

-(NSDictionary *)convertToDict
{
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:_ID,@"ID",_createTime,@"createTime",_userName,@"userName",[NSNumber numberWithInteger:_height],@"height",[NSNumber numberWithFloat:_weight],@"weight",_phoneNum,@"phoneNum",[NSNumber numberWithBool:_state],@"state",_frontPath,@"frontPath",_sidePath,@"sidePath",_backgroundPath,@"backgroundPath",nil];
 
//    NSDictionary *dict = [[NSDictionary alloc] initWithObjects:
//                                     [NSArray arrayWithObjects:_ID, _createTime, _userName, [NSNumber numberWithInteger:_height], [NSNumber numberWithFloat:_weight], _phoneNum, [NSNumber numberWithBool:_state], _frontPath, _sidePath, _backgroundPath,nil]
//                                                       forKeys:[NSArray arrayWithObjects:@"ID", @"createTime",@"userName", @"height", @"weight", @"phoneNum", @"state", @"frontPath", @"sidePath", @"backgroundPath", nil]];
    return dict;
}
@end
