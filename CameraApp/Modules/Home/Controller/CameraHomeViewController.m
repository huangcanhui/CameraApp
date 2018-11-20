//
//  CameraHomeViewController.m
//  CameraApp
//
//  Created by aieffei on 2018/11/20.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CameraHomeViewController.h"
#import "CHPhotoLibraryViewController.h"

#ifdef DEBUG
#import "CameraHomeViewController+Debug_DevelopmentViewController.h"
#endif

@interface CameraHomeViewController ()

@end

@implementation CameraHomeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //隐藏导航条
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //将导航条显示
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = HexColor(0xffffff);
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [btn setTitle:@"点我" forState:UIControlStateNormal];
    [btn setTitleColor:HexColor(0x000000) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
#ifdef DEBUG
    [self addDebugDevelopmentButton];
#endif
}

- (void)clickBtn
{
    CHPhotoLibraryViewController *phtotoVC = [CHPhotoLibraryViewController new];
    CHNavigationController *naVC = [[CHNavigationController alloc] initWithRootViewController:phtotoVC];
    [self.navigationController pushViewController:phtotoVC animated:YES];
//    [self presentViewController:naVC animated:YES completion:nil];
    NSLog(@"点击了");
}


@end
