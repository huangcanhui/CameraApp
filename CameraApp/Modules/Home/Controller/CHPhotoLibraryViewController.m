//
//  CHPhotoLibraryViewController.m
//  CameraApp
//
//  Created by aieffei on 2018/11/20.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CHPhotoLibraryViewController.h"
#import "JQFMDB.h"
#import "Personal.h"
#import "CHPhotoLibraryListViewController.h"
#import "CHBrowserBottomView.h"
#import "LLPhotoBrowser.h"

@interface CHPhotoLibraryViewController ()<UIScrollViewDelegate, LLPhotoBrowserDelegate>
/**
 * 底部的视图
 */
@property (nonatomic, strong)CHBrowserBottomView *bottomView;
/**
 * 数据源
 */
@property (nonatomic, strong)NSArray *dataSource;
/**
 * 图片展示区
 */
@property (nonatomic, strong)UIView *imageView;

@end

@implementation CHPhotoLibraryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.navigationItem.title = @"图库";
    
    if (_type == enterTypeOnCamera) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"所有图片" style:UIBarButtonItemStyleDone target:self action:@selector(popToPhotoLibrary)];
    }
    
//    [MBProgressHUD showInfoMessage:@"加载中,请稍后..."];
    
    [self.view addSubview:self.imageView];
    
    [self lookupDataBase]; //查找数据库
    
    [self.view addSubview:self.bottomView];
}


#pragma mark - 查找数据中
- (void)lookupDataBase
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        JQFMDB *db = [JQFMDB shareDatabase];
        [self applyViewWithDataBase:[db jq_lookupTable:@"user" dicOrModel:[Personal class] whereFormat:nil]];
    });
}

- (void)applyViewWithDataBase:(NSArray *)array
{
    NSMutableArray *arrayM = [NSMutableArray array];
    for (Personal *person in array) {
        if (person != nil) { //数据是否为空
            [arrayM addObject:[UIImage imageWithData:person.photoData]];
        }
    }
    LLPhotoBrowser *photoBrowser = [[LLPhotoBrowser alloc] initWithImages:[arrayM copy] currentIndex:0];
    photoBrowser.delegate = self;
    [self.imageView addSubview:photoBrowser.view];
    
    [self addChildViewController:photoBrowser];
    [self.view addSubview:self.bottomView];
 
//    [MBProgressHUD hideHUD];
}

- (void)photoBrowser:(LLPhotoBrowser *)photoBrowser didSelectImage:(id)image
{
    NSLog(@"%@", image);
}


- (void)setType:(enterType)type
{
    _type = type ? enterTypeOnCamera : enterTypeOnPhotoLibrary;
}

#pragma mark - 添加底部视图
- (CHBrowserBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[CHBrowserBottomView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - kTopHeight - kTabBarHeight, SCREEN_WIDTH, kTabBarHeight)];
        _bottomView.PhotoBrowserDeleteButtonClick = ^(UIButton * btn) {
            [CHProgressHUD showSuccess:@"删除"];
        };
        
        _bottomView.PhotoBrowserShareButtonClick = ^(UIButton * btn) {
            [CHProgressHUD showSuccess:@"分享"];
        };
    }
    return _bottomView;
}


#pragma mark - 跳转到全部图片
- (void)popToPhotoLibrary
{
    CHPhotoLibraryListViewController *listVC = [CHPhotoLibraryListViewController new];
    [self.navigationController pushViewController:listVC animated:YES];
}

- (UIView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIView alloc] initWithFrame:CGRectMake(0, -kTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kTabBarHeight)];
        _imageView.backgroundColor = [UIColor redColor];
    }
    return _imageView;
}




@end
