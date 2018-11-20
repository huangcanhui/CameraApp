//
//  DebugViewController.m
//  CameraApp
//
//  Created by aieffei on 2018/11/20.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "DebugViewController.h"
#import "Debug_DevelopmentModel.h"
#import "CHUtil.h"

@interface DebugViewController ()<UITableViewDelegate, UITableViewDataSource>
/**
 * UITableView
 */
@property (nonatomic, strong)UITableView *tableView;
/**
 * 数据源
 */
@property (nonatomic, strong)NSArray *urls;

@end

@implementation DebugViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = HexColor(0x000000);
    
    self.navigationItem.title = @"开发环境API设置";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"只关闭" style:UIBarButtonItemStyleDone target:self action:@selector(closeViewController)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"重启" style:UIBarButtonItemStyleDone target:self action:@selector(restarApp)];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableView
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.urls.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"请选择一个开发环境";
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return @"请点击右上角的'重启'重新进入";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Debug"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Debug"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:17] ;
        cell.textLabel.textColor = [UIColor blackColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:11] ;
        cell.detailTextLabel.textColor = [UIColor blueColor] ;
    }
    Debug_DevelopmentModel *obj = self.urls[indexPath.row];
    cell.textLabel.text = obj.name;
    cell.detailTextLabel.text = obj.url;
    
    if ([obj.url isEqualToString:[self currentUrl]]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark ;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone ;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消选择
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    [self pickUpUrlAtRow:indexPath.row ];
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic] ;
}

- (NSString *)currentUrl
{
    return [CHUtil configFileValueWithKey:@"Dev_Url"];
}

- (void)pickUpUrlAtRow:(NSUInteger)rowIndex
{
    Debug_DevelopmentModel *d = self.urls[rowIndex] ;
    
    [CHUtil writeToConfigFileWithKey:@"Dev_Url" andValue:d.url] ;

}

#pragma mark - lazy
- (NSArray *)urls
{
    if (!_urls) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Urls" ofType:@"plist"];
        NSArray *urls = [[NSArray alloc]initWithContentsOfFile:path];
        NSMutableArray *arrayM = [NSMutableArray array];
        for (NSDictionary *dic in urls) {
            Debug_DevelopmentModel *de = [[Debug_DevelopmentModel alloc]initWithDictionary:dic] ;
            [arrayM addObject:de] ;
        }
        _urls = [arrayM copy] ;
    }
    return _urls;
}

#pragma mark - 只关闭页面，并不进行环境的切换
- (void)closeViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 关闭重启后，将进行环境的切换
- (void)restarApp
{
    exit(0);
}

@end
