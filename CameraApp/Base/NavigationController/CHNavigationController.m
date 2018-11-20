//
//  CHNavigationController.m
//  CameraApp
//
//  Created by aieffei on 2018/11/20.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CHNavigationController.h"

@interface CHNavigationController ()

@property (nonatomic, strong) UIView *backgroundView;

@end

@implementation CHNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        UINavigationBar *bar = self.navigationBar;
        bar.barTintColor= GLOBAL_COLOR ;//设置导航栏背景颜色
        [bar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        bar.tintColor = [UIColor blackColor]; //设置View颜色
        bar.translucent = NO ;
        [bar setShadowImage:[UIImage new]] ;
        [bar setTitleTextAttributes:@{
                                      NSForegroundColorAttributeName:[UIColor whiteColor],//设置title的颜色
                                      NSFontAttributeName:[UIFont systemFontOfSize:16]
                                      }];
        
        
        //设置UIBarButtonItem的外观
        UIBarButtonItem *barItem=[UIBarButtonItem appearance];
        //item上边的文字样式
        NSDictionary *fontDic=@{
                                NSForegroundColorAttributeName:[UIColor whiteColor],//设置barbutton里面字体的颜色
                                NSFontAttributeName:[UIFont systemFontOfSize:14]  //粗体
                                };
        [barItem setTitleTextAttributes:fontDic
                               forState:UIControlStateNormal];
        [barItem setTitleTextAttributes:fontDic
                               forState:UIControlStateHighlighted];
        
        //设置返回键
        UIImage* image = [[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        bar.backIndicatorImage = image ;
        bar.backIndicatorTransitionMaskImage = image ;
        [barItem setBackButtonTitlePositionAdjustment:UIOffsetMake(- SCREEN_HEIGHT, 0) forBarMetrics:UIBarMetricsDefault];
    }
    return self ;
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent ;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0 ) {
        viewController.hidesBottomBarWhenPushed  = YES ;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)setBackgroundColorAlpha:(CGFloat )alpha
{
    if (alpha <= 0 ) {
        self.backgroundView.hidden = YES ;
        return ;
    }
    UIColor *color = self.navigationBar.barTintColor;
    if (!self.backgroundView) {
        self.backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, -20, self.navigationBar.ch_width, kTopHeight)];
        for (UIView *view in self.navigationBar.subviews) {
            if ([[view description] hasPrefix:@"<_UINavigationBarBackground"]) {
                [self.navigationBar insertSubview:self.backgroundView belowSubview:view];
                break ;
            }
        }
    }
    
    self.backgroundView.hidden = NO ;
    self.backgroundView.backgroundColor = [color colorWithAlphaComponent:alpha];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
