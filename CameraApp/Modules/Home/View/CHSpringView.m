//
//  CHSpringView.m
//  CameraApp
//
//  Created by aieffei on 2018/11/21.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CHSpringView.h"

@interface CHSpringView ()

@property (nonatomic, strong)UIView *lineView;

@property (nonatomic, strong)UIView *verticalView;

@property (nonatomic, assign)CGRect rect;

//@property (nonatomic, strong)UIView *horisonView;

@end

@implementation CHSpringView

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
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 32, 4)];
    _lineView.center = CGPointMake(frame.size.width / 2 - 16, frame.size.height / 2 - 2);
    _lineView.backgroundColor = HexColor(0xffffff);
    [self addSubview:_lineView];
    
    _verticalView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 3)];
    _verticalView.center = CGPointMake(frame.size.width / 2 - 10, frame.size.height / 2 - 2);
    _verticalView.backgroundColor = KClearColor;
    [self addSubview:_verticalView];
}

- (void)getGravityX:(double)x gravityY:(double)y gravity:(double)z
{
    double zThtea = atan2(z, sqrt(x * x + y * y)) / M_PI * (-90) * 2 - 90; //手机与水平面的夹角
    CameraStatus status = cameraStatusHightLight;
    if (fabs(y) > fabs(x)) { //竖屏
        _lineView.frame = CGRectMake(self.rect.size.width / 2 - 16, self.rect.size.height / 2 - 2, 32, 4);
        _verticalView.frame = CGRectMake(self.rect.size.width / 2 - 10, self.rect.size.height / 2 + z * 100, 20, -z * 100);
        if (85 <= -zThtea && -zThtea <= 95) {
            _lineView.backgroundColor = [UIColor greenColor];
            _verticalView.backgroundColor = [UIColor greenColor];
            status = cameraStatusHightLight;
        } else if (60 <= -zThtea && -zThtea <= 120) {
            _lineView.backgroundColor = [UIColor redColor];
            _verticalView.backgroundColor = [UIColor redColor];
            status = cameraStatusNormal;
        } else {
            _lineView.backgroundColor = [UIColor blueColor];
            _verticalView.backgroundColor = [UIColor blueColor];
            status = cameraStatusNormal;
        }
    } else { //横屏
        _lineView.frame = CGRectMake(self.rect.size.width / 2 - 2, self.rect.size.height / 2 - 16, 4, 32);
        _verticalView.frame = CGRectMake(self.rect.size.width / 2 + z * 100, self.rect.size.height / 2 - 10, -z * 100, 20);
        if (85 <= -zThtea && -zThtea <= 95) {
            _lineView.backgroundColor = [UIColor greenColor];
            _verticalView.backgroundColor = [UIColor greenColor];
            status = cameraStatusHightLight;
        } else if (60 <= -zThtea && -zThtea <= 120) {
            _lineView.backgroundColor = [UIColor redColor];
            _verticalView.backgroundColor = [UIColor redColor];
            status = cameraStatusNormal;
        } else {
            _lineView.backgroundColor = [UIColor blueColor];
            _verticalView.backgroundColor = [UIColor blueColor];
            status = cameraStatusNormal;
        }
    }
    if (self.getAngleToChangeCameraButtonStatus) {
        self.getAngleToChangeCameraButtonStatus(status);
    }
}
@end
