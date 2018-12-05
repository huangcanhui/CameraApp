//
//  TakePhotoAlertView.m
//  CameraApp
//
//  Created by aieffei on 2018/11/29.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "TakePhotoAlertView.h"
#import <UIImage+GIF.h>

@interface  TakePhotoAlertView()
/**
 * 竖屏
 */
@property (nonatomic, strong)UILabel *verticalLabel;
/**
 * 横屏
 */
@property (nonatomic, strong)UILabel *horiLabel;
/**
 * 蒙层
 */
@property (nonatomic, strong)UIView *mongonlianView;
@property (nonatomic, strong)UIImageView *mongoImageView;
@property (nonatomic, strong)UIImageView *otherImageView;
@property (nonatomic, strong)UILabel *monVerLabel;

@property (nonatomic, assign)CGRect rect;
@end

@implementation TakePhotoAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpView:frame];
        
        self.rect = frame;
    }
    return self;
}

- (void)setUpView:(CGRect)frame
{
    _verticalLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    _verticalLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    _verticalLabel.center = CGPointMake(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2);
    _verticalLabel.text = @"中心弹簧变绿才可以拍摄";
    _verticalLabel.textColor = HexColor(0xffffff);
    _verticalLabel.font = [UIFont systemFontOfSize:15];
    _verticalLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_verticalLabel];
    
    _horiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    _horiLabel.layer.cornerRadius = 10;
    _horiLabel.center = CGPointMake(CGRectGetWidth(self.bounds) / 2 + 60, CGRectGetHeight(self.bounds) / 2);
    _horiLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    _horiLabel.text = @"中心弹簧变绿才可以拍摄";
    _horiLabel.textColor = HexColor(0xffffff);
    _horiLabel.textAlignment = NSTextAlignmentCenter;
    _horiLabel.font = [UIFont systemFontOfSize:15];
    _horiLabel.transform = CGAffineTransformMakeRotation(90 * M_PI / 180);
    [self addSubview:_horiLabel];
}

- (void)getGravityX:(double)x gravityY:(double)y gravity:(double)z
{
    double zThtea = atan2(z, sqrt(x * x + y * y)) / M_PI * (-90) * 2 - 90; //手机与水平面的夹角
    if (fabs(y) > fabs(x)) { //竖屏
        self.horiLabel.hidden = YES;
        if (85 <= -zThtea && -zThtea <= 95) {
            self.verticalLabel.hidden = YES;
            [self.mongonlianView removeFromSuperview];
        } else if (60 <= -zThtea && -zThtea <= 120) {
            self.verticalLabel.hidden = NO;
            [self.mongonlianView removeFromSuperview];
        } else if (40 <= -zThtea && -zThtea <= 140){
            self.verticalLabel.hidden = YES;
            [self.mongoImageView removeFromSuperview];
            self.monVerLabel.hidden = YES;
            [self addSubview:self.mongonlianView];
            [self.mongonlianView addSubview:self.otherImageView];
        } else {
            self.verticalLabel.hidden = YES;
            [self.otherImageView removeFromSuperview];
            self.monVerLabel.hidden = NO;
            [self addSubview:self.mongonlianView];
            [self.mongonlianView addSubview:self.mongoImageView];
            [self.mongonlianView addSubview:self.monVerLabel];
        }
    } else { //横屏
        self.verticalLabel.hidden = YES;
        if (85 <= -zThtea && -zThtea <= 95) {
            self.horiLabel.hidden = YES;
        } else {
            self.horiLabel.hidden = NO;
        }
    }
}

- (UIView *)mongonlianView
{
    if (!_mongonlianView) {
        _mongonlianView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.rect.size.height)];
        _mongonlianView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.75];
    }
    return _mongonlianView;
}

- (UIImageView *)mongoImageView
{
    if (!_mongoImageView) {
        _mongoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - kRealValue(25), SCREEN_HEIGHT / 2 - kRealValue(100), kRealValue(50), kRealValue(85))];
        NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:2];
        for (int i = 0; i < 2; i++) {
            NSString *string = [NSString stringWithFormat:@"mon_ver_%d", i + 1];
            UIImage *image = [UIImage imageNamed:string];
            [imageArray addObject:image];
        }
        _mongoImageView.contentMode = UIViewContentModeScaleAspectFit;
        _mongoImageView.animationImages = imageArray;
        _mongoImageView.animationDuration = 1;
        [_mongoImageView startAnimating];
    }
    return _mongoImageView;
}

- (UIImageView *)otherImageView
{
    if (!_otherImageView) {
        _otherImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - kRealValue(78), SCREEN_HEIGHT / 2 - kRealValue(150), kRealValue(157), kRealValue(218))];
        _otherImageView.image = [UIImage imageNamed:@"takePhoto_tips"];
        _otherImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _otherImageView;
}

- (UILabel *)monVerLabel
{
    if (!_monVerLabel) {
        _monVerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        _monVerLabel.center = CGPointMake(SCREEN_WIDTH / 2, self.mongoImageView.ch_bottom + 30);
        _monVerLabel.text = @"请保持手机竖直，不要前后倾斜";
        _monVerLabel.textAlignment = NSTextAlignmentCenter;
        _monVerLabel.textColor = HexColor(0xffffff);
        _monVerLabel.font = [UIFont systemFontOfSize:14];
    }
    return _monVerLabel;
}

- (void)dismiss
{
   [[self.mongonlianView getKeyWindow] removeFromSuperview];
   [self.mongonlianView removeFromSuperview];
}


@end
