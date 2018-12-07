//
//  Authority_SettingViewController.m
//  CameraApp
//
//  Created by aieffei on 2018/12/7.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "Authority_SettingViewController.h"

@interface Authority_SettingViewController ()
/**
 * 按钮
 */
@property (nonatomic, strong)UIButton *settingButton;
/**
 * 图片
 */
@property (nonatomic, strong)UIImageView *imageView;
/**
 * 标题
 */
@property (nonatomic, strong)UILabel *titleLabel;
/**
 * 权限内容
 */
@property (nonatomic, strong)UILabel *authLabel;

@end

@implementation Authority_SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"美房相机";
    
    self.view.backgroundColor = HexColor(0x000000);
    
    [self initUIView];
}

#pragma mark - 创建UI
- (void)initUIView
{
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.authLabel];
    [self.view addSubview:self.settingButton];
}

#pragma mark - 懒加载
- (UILabel *)authLabel
{
    if (!_authLabel) {
        _authLabel = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(16), _titleLabel.ch_bottom, SCREEN_WIDTH - kRealValue(32), kRealValue(100))];
        _authLabel.text = @"1.允许\"美房相机\"使用数据\n\n2.允许\"美房相机\"访问相机\n\n";
        _authLabel.textAlignment = NSTextAlignmentCenter;
        _authLabel.textColor = HexColor(0xffffff);
        _authLabel.font = [UIFont systemFontOfSize:15];
        _authLabel.numberOfLines = 0;
    }
    return _authLabel;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(16), self.imageView.ch_bottom - kRealValue(50), SCREEN_WIDTH - kRealValue(32), kRealValue(40))];
        _titleLabel.text = @"你需要开启一下权限才能正常使用\"美房相机\"";
        _titleLabel.textColor = HexColor(0xffffff);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _titleLabel;
}
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kRealValue(12), kRealValue(20), kRealValue(350), kRealValue(270))];
        _imageView.image = [UIImage imageNamed:@"authority_setting"];
        _imageView.contentMode = UIViewContentModeBottom;
    }
    return _imageView;
}

- (UIButton *)settingButton
{
    if (!_settingButton) {
        _settingButton = [[UIButton alloc] initWithFrame:CGRectMake(kRealValue(32), SCREEN_HEIGHT - kTopHeight - kTabBarHeight - kRealValue(100), SCREEN_WIDTH - kRealValue(64), kRealValue(50))];
        [_settingButton setTitle:@"立即设置" forState:UIControlStateNormal];
        [_settingButton setTitleColor:HexColor(0xffffff) forState:UIControlStateNormal];
        _settingButton.backgroundColor = HexColor(0x007aff);
        _settingButton.layer.cornerRadius = 6;
        _settingButton.layer.masksToBounds = YES;
        [_settingButton addTarget:self action:@selector(authoritySetting:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _settingButton;
}

- (void)authoritySetting:(UIButton *)btn
{
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

@end
