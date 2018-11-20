//
//  ViewController.m
//  CameraApp
//
//  Created by aieffei on 2018/11/7.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "ViewController.h"
#import "CHProgressHUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = HexColor(0xffffff);
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    btn.backgroundColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
}

- (void)clickBtn:(UIButton *)btn
{
//    [CHProgressHUD showMessage:@"加载中，请售后"];
//    [CHProgressHUD showLoading:@"加载中"];
    [CHProgressHUD showSuccess:@"成功了"];
    
    NSLog(@"点击了");
}


@end
