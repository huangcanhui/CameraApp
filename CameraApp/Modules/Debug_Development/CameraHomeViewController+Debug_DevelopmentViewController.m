//
//  CameraHomeViewController+Debug_DevelopmentViewController.m
//  CameraApp
//
//  Created by aieffei on 2018/11/20.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CameraHomeViewController+Debug_DevelopmentViewController.h"
#import "DebugViewController.h"

@implementation CameraHomeViewController (Debug_DevelopmentViewController)

- (void)addDebugDevelopmentButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 150, 80, 40);
    button.backgroundColor = [UIColor purpleColor];
    [button setTitle:@"设置环境" forState:UIControlStateNormal] ;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal] ;
    [self.view addSubview:button] ;
    [button addTarget:self action:@selector(setDevelopEnv) forControlEvents:UIControlEventTouchUpInside] ;
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [button addGestureRecognizer:panGesture];
    
}

- (void)pan:(UIPanGestureRecognizer *)panGesture
{
    if (panGesture.state == UIGestureRecognizerStateChanged) {
        CGPoint movement = [panGesture translationInView:panGesture.view.superview] ;
        panGesture.view.ch_left = movement.x + panGesture.view.ch_left ;
        panGesture.view.ch_top = movement.y + panGesture.view.ch_top ;
        [panGesture setTranslation:CGPointZero inView:panGesture.view.superview];
    }
}

- (void)setDevelopEnv
{
    DebugViewController *vc = [DebugViewController new];
    CHNavigationController *nav = [[CHNavigationController alloc]initWithRootViewController:vc] ;
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController ;
    [rootVC presentViewController:nav animated:YES completion:nil] ;
}

@end
