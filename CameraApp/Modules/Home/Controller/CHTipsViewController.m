//
//  CHTipsViewController.m
//  CameraApp
//
//  Created by aieffei on 2018/11/21.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CHTipsViewController.h"
#import "JQFMDB.h"
#import "DBObject.h"

@interface CHTipsViewController ()
@property (nonatomic, strong)JQFMDB *db;
@end

@implementation CHTipsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = HexColor(0xffffff);
    
    self.navigationItem.title = @"引导页面";
    
    NSArray *array = [self.db jq_lookupTable:@"PHOTO" dicOrModel:[DBObject class] whereFormat:nil];
    NSLog(@"查找数据表中的数据:%@", array);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
