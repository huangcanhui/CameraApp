//
//  CHWebBaseViewController.m
//  CameraApp
//
//  Created by aieffei on 2018/11/30.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CHWebBaseViewController.h"

@interface CHWebBaseViewController ()

@end

@implementation CHWebBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)updateNavigationItems
{
    if (_isShowCloseBtn) {
        if (self.webView.canGoBack) {
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
            [self addNavigationItemWithImageNames:@[@"back", @"close"] isLeft:YES target:self action:@selector(leftBtnClick:) tags:@[@2000, @2001]];
        } else {
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
            if (kiOS9Later) {
                [self addNavigationItemWithImageNames:@[@"back"] isLeft:YES target:self action:@selector(leftBtnClick:) tags:@[@2000]];
            }
        }
    }
}

-(void)leftBtnClick:(UIButton *)btn{
    switch (btn.tag) {
        case 2000:
            [super backBtnClicked];
            
            break;
        case 2001:
        {
            if (self.presentingViewController) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
            
            break;
        default:
            break;
    }
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
