//
//  AFNetManager.m
//  Cybespoke
//
//  Created by pengpeng on 15/10/8.
//  Copyright © 2015年 pengpeng. All rights reserved.
//

#import "PhotoDBManger.h"
#import "User.h"

@interface PhotoDBManger()
{
    NSString *filePath;
}
@end

@implementation PhotoDBManger

+(PhotoDBManger *)manager
{
    static PhotoDBManger *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[PhotoDBManger alloc] init];
    });
    return _instance;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docDir = [paths objectAtIndex:0];
        filePath = [NSString stringWithFormat:@"%@/db.plist", docDir];
    }
    return self;
}

-(NSArray *)readData
{
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    
    NSFileManager* fm=[NSFileManager defaultManager];
//    NSArray *files = [fm subpathsOfDirectoryAtPath:filePath error:nil];
//    NSLog(@"%@", NSHomeDirectory());
    NSArray *photoData = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    for (NSDictionary *photoDict in photoData) {
        User *tmpUser = [[User alloc] initFromDict:photoDict];
        [photos addObject:tmpUser];
    }
    //将数组中的元素按照user创建时间进行排序
    NSArray * result = [photos sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        User *user1 = obj1;
        User *user2 = obj2;
        return [user2.createTime compare:user1.createTime];
    }];
    return result;
}

-(void)writeData:(NSArray *)photos
{
    NSMutableArray *photoArray = [[NSMutableArray alloc] init];
    for (User *user in photos) {
        [photoArray addObject:[user convertToDict]];
    }
    [photoArray writeToFile:filePath atomically:YES];
}

-(void)saveUser:(User *)user
{
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    NSArray *photoData = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    BOOL isIn = NO;
    for (NSDictionary *photoDict in photoData) {
        User *tmpUser  = [[User alloc] initFromDict:photoDict];
        if ([tmpUser.ID isEqualToString:user.ID]) {
            isIn = YES;
            [photos addObject:[user convertToDict]];
        }
        [photos addObject:photoDict];
    }
    if (isIn == NO) {
        [photos addObject:[user convertToDict]];
    }
    [photos writeToFile:filePath atomically:YES];
}

@end
