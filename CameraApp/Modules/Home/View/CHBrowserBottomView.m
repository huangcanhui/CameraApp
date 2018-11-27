//
//  CHBrowserBottomView.m
//  CameraApp
//
//  Created by aieffei on 2018/11/23.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CHBrowserBottomView.h"

@interface CHBrowserBottomView ()
/**
 * 删除
 */
@property (nonatomic, strong)CHBottomButton *deleteButton;
/**
 * 好友
 */
@property (nonatomic, strong)CHBottomButton *sessionButton;
/**
 * 朋友圈
 */
@property (nonatomic, strong)CHBottomButton *timeLineButton;

@end

@implementation CHBrowserBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = HexColor(0x232323);
        [self setupView:frame];
    }
    return self;
}

- (void)setupView:(CGRect)frame
{
    CGFloat btnW = (frame.size.width - 2) / 5;
    //删除按钮
    self.deleteButton = [[CHBottomButton alloc] initWithFrame:CGRectMake(0, 0, btnW, 49)];
    [self.deleteButton setImage:[UIImage imageNamed:@"Album_icon_delete"] forState:UIControlStateNormal];
    [self.deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    self.deleteButton.titleLabel.textColor = KWhiteColor;
    self.deleteButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.deleteButton.titleLabel.font = [UIFont systemFontOfSize:13];
    self.deleteButton.backgroundColor = HexColor(0x232323);
    [self.deleteButton addTarget:self action:@selector(clickDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.deleteButton];
    
    //分享朋友圈按钮
    self.timeLineButton = [[CHBottomButton alloc] initWithFrame:CGRectMake(self.deleteButton.ch_right + 1, 0, 2 * btnW, 49)];
    [self.timeLineButton setImage:[UIImage imageNamed:@"Album_icon_timeline"] forState:UIControlStateNormal];
    [self.timeLineButton setTitle:@"分享朋友圈" forState:UIControlStateNormal];
    self.timeLineButton.titleLabel.textColor = KWhiteColor;
    self.timeLineButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLineButton.backgroundColor = HexColor(0x232323);
    self.timeLineButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.timeLineButton addTarget:self action:@selector(clickTimelineButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.timeLineButton];
    
    //分享好友按钮
    self.sessionButton = [[CHBottomButton alloc] initWithFrame:CGRectMake(self.timeLineButton.ch_right + 1, 0, 2 * btnW , 49)];
    [self.sessionButton setImage:[UIImage imageNamed:@"Album_icon_session"] forState:UIControlStateNormal];
    [self.sessionButton setTitle:@"分享好友" forState:UIControlStateNormal];
    self.sessionButton.titleLabel.textColor = KWhiteColor;
    self.sessionButton.backgroundColor = HexColor(0x232323);
    self.sessionButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.sessionButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.sessionButton addTarget:self action:@selector(clickSessionButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.sessionButton];

    //细线1
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(self.deleteButton.ch_right, 5, 1, 35)];
    lineView1.backgroundColor = KWhiteColor;
    [self addSubview:lineView1];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(self.timeLineButton.ch_right, 5, 1, 35)];
    lineView2.backgroundColor = KWhiteColor;
    [self addSubview:lineView2];
    
}

- (void)clickDeleteButton:(CHBottomButton *)btn
{
    if (self.PhotoBrowserDeleteButtonClick) {
        self.PhotoBrowserDeleteButtonClick(btn);
    }
}

- (void)clickTimelineButton:(CHBottomButton *)btn
{
    if (self.PhotoBrowserShareTimeLineButtonClick) {
        self.PhotoBrowserShareTimeLineButtonClick(btn);
    }
}

- (void)clickSessionButton:(CHBottomButton *)btn
{
    if (self.PhotoBrowserShareSessionButtonClick) {
        self.PhotoBrowserShareSessionButtonClick(btn);
    }
}

//- (void)clickShareButton:(UIButton *)btn
//{
//    if (self.PhotoBrowserShareButtonClick) {
//        self.PhotoBrowserShareButtonClick(btn);
//    }
//}
@end
