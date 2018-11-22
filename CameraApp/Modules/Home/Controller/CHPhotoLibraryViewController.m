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

@interface CHPhotoLibraryViewController ()
@property (nonatomic, strong)UIImageView *imageView;
@end

@implementation CHPhotoLibraryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.navigationItem.title = @"图库";
    
    [self.view addSubview:self.imageView];
    
    [self getLastImageViewOnFMDB];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"所有图片" style:UIBarButtonItemStyleDone target:self action:@selector(popToPhotoLibrary)];
}

#pragma mark - 跳转到全部图片
- (void)popToPhotoLibrary
{
    CHPhotoLibraryListViewController *listVC = [CHPhotoLibraryListViewController new];
    [self.navigationController pushViewController:listVC animated:YES];
}

- (void)getLastImageViewOnFMDB
{
    //取最后一张图片
    JQFMDB *db = [JQFMDB shareDatabase];
    NSArray *array = [db jq_lookupTable:@"user" dicOrModel:[Personal class] whereFormat:@"where pkid='%d'", [db lastInsertPrimaryKeyId:@"user"]];
    for (Personal *personal in array) {
        _imageView.image = [UIImage imageWithData:personal.photoData];
    }
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

@end
