//
//  TakePhotoAlertView.m
//  CameraApp
//
//  Created by aieffei on 2018/11/29.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "TakePhotoAlertView.h"

@interface  TakePhotoAlertView()
///**
// * 竖屏
// */
//@property (nonatomic, strong)UILabel *verticalLabel;
///**
// * 横屏
// */
//@property (nonatomic, strong)UILabel *horiLabel;
/**
 * 蒙层
 */
@property (nonatomic, strong)UIView *mongonlianVerView; //竖屏蒙层
@property (nonatomic, strong)UIView *mongonlianHorView; //横屏蒙层
@end

@implementation TakePhotoAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self setUpView:frame];
        [self setMongonlianViewFrame:frame];
    }
    return self;
}

- (void)setMongonlianViewFrame:(CGRect)frame
{
    //竖屏
    self.mongonlianVerView = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width / 2 - kRealValue(115), frame.size.height - kRealValue(220), kRealValue(230), kRealValue(111))];
    self.mongonlianVerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.75];
    self.mongonlianVerView.layer.cornerRadius = 8;
    self.mongonlianVerView.layer.masksToBounds = YES;
    [self addSubview:self.mongonlianVerView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, kRealValue(4), self.mongonlianVerView.ch_width, kRealValue(20))];
    label.text = @"请调整手机与地面垂直";
    label.textColor = HexColor(0xffffff);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    [self.mongonlianVerView addSubview:label];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.mongonlianVerView.ch_width / 2 - kRealValue(61), label.ch_bottom, kRealValue(122), kRealValue(98))];
    imageView.image = [UIImage imageNamed:@"angle_tips"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.mongonlianVerView addSubview:imageView];
    
    //横屏
    self.mongonlianHorView = [[UIView alloc] initWithFrame:CGRectMake(kRealValue(-40), frame.size.height / 2 - kRealValue(80), kRealValue(230), kRealValue(111))];
    self.mongonlianHorView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.75];
    self.mongonlianHorView.layer.cornerRadius = 8;
    self.mongonlianHorView.layer.masksToBounds = YES;
    self.mongonlianHorView.transform = CGAffineTransformMakeRotation(90 * M_PI / 180);
    [self addSubview:self.mongonlianHorView];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, kRealValue(4), self.mongonlianHorView.ch_width, kRealValue(20))];
    label2.text = @"请调整手机与地面垂直";
    label2.textColor = HexColor(0xffffff);
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont systemFontOfSize:14];
    [self.mongonlianHorView addSubview:label2];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(self.mongonlianHorView.ch_width / 2 - kRealValue(61), label2.ch_bottom, kRealValue(122), kRealValue(98))];
    imageView2.image = [UIImage imageNamed:@"angle_tips"];
    imageView2.contentMode = UIViewContentModeScaleAspectFit;
    [self.mongonlianHorView addSubview:imageView2];
}

- (void)getGravityX:(double)x gravityY:(double)y gravity:(double)z
{
    double zThtea = atan2(z, sqrt(x * x + y * y)) / M_PI * (-90) * 2 - 90; //手机与水平面的夹角
    if (fabs(y) > fabs(x)) { //竖屏
        self.mongonlianHorView.hidden = YES;
        if (85 <= -zThtea && -zThtea <= 95) { //角度正常允许拍摄
            self.mongonlianVerView.hidden = YES;
        } else {
            self.mongonlianVerView.hidden = NO;
        }
    } else { //横屏
        self.mongonlianVerView.hidden = YES;
        if (85 <= -zThtea && -zThtea <= 95) { //角度正常允许拍摄
            self.mongonlianHorView.hidden = YES;
        } else {
            self.mongonlianHorView.hidden = NO;
        }
    }
}

//- (void)setUpView:(CGRect)frame
//{
//    _verticalLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
//    _verticalLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
//    _verticalLabel.center = CGPointMake(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2);
//    _verticalLabel.text = @"中心弹簧变绿才可以拍摄";
//    _verticalLabel.textColor = HexColor(0xffffff);
//    _verticalLabel.font = [UIFont systemFontOfSize:15];
//    _verticalLabel.textAlignment = NSTextAlignmentCenter;
//    [self addSubview:_verticalLabel];
//
//    _horiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
//    _horiLabel.layer.cornerRadius = 10;
//    _horiLabel.center = CGPointMake(CGRectGetWidth(self.bounds) / 2 + 60, CGRectGetHeight(self.bounds) / 2);
//    _horiLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
//    _horiLabel.text = @"中心弹簧变绿才可以拍摄";
//    _horiLabel.textColor = HexColor(0xffffff);
//    _horiLabel.textAlignment = NSTextAlignmentCenter;
//    _horiLabel.font = [UIFont systemFontOfSize:15];
//    _horiLabel.transform = CGAffineTransformMakeRotation(90 * M_PI / 180);
//    [self addSubview:_horiLabel];
//}

//- (void)getGravityX:(double)x gravityY:(double)y gravity:(double)z
//{
//    double zThtea = atan2(z, sqrt(x * x + y * y)) / M_PI * (-90) * 2 - 90; //手机与水平面的夹角
//    if (fabs(y) > fabs(x)) { //竖屏
//        self.horiLabel.hidden = YES;
//        if (85 <= -zThtea && -zThtea <= 95) {
//            self.verticalLabel.hidden = YES;
//        } else {
//            self.verticalLabel.hidden = NO;
//        }
//    } else { //横屏
//        self.verticalLabel.hidden = YES;
//        if (85 <= -zThtea && -zThtea <= 95) {
//            self.horiLabel.hidden = YES;
//        } else {
//            self.horiLabel.hidden = NO;
//        }
//    }
//}

@end
