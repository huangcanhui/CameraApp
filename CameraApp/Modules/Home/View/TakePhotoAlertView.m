//
//  TakePhotoAlertView.m
//  CameraApp
//
//  Created by aieffei on 2018/11/29.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "TakePhotoAlertView.h"

@interface  TakePhotoAlertView()
/**
 * 竖屏
 */
@property (nonatomic, strong)UILabel *verticalLabel;
/**
 * 横屏
 */
@property (nonatomic, strong)UILabel *horiLabel;

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
        } else {
            self.verticalLabel.hidden = NO;
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


@end
