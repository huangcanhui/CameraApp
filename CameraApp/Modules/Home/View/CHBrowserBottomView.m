//
//  CHBrowserBottomView.m
//  CameraApp
//
//  Created by aieffei on 2018/11/23.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CHBrowserBottomView.h"

@interface CHBrowserBottomView ()

@end

@implementation CHBrowserBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = KBlackColor;
        [self setupView:frame];
    }
    return self;
}

- (void)setupView:(CGRect)frame
{
    //删除按钮
    UIButton *deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width / 2 - 1, kRealValue(40))];
    deleteButton.backgroundColor = KBlackColor;
    [deleteButton setImage:[UIImage imageNamed:@"Album_icon_delete"] forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(clickDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:deleteButton];
    
    //分享按钮
    UIButton *shareButton = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width / 2 + 1, 0, frame.size.width / 2 - 1, kRealValue(40))];
    shareButton.backgroundColor = KBlackColor;
    [shareButton setImage:[UIImage imageNamed:@"Album_icon_share"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(clickShareButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:shareButton];
    
    //细线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width / 2 - 1, 2, 2, kRealValue(40))];
    lineView.backgroundColor = KWhiteColor;
    [self addSubview:lineView];
    
}

- (void)clickDeleteButton:(UIButton *)btn
{
    if (self.PhotoBrowserDeleteButtonClick) {
        self.PhotoBrowserDeleteButtonClick(btn);
    }
}

- (void)clickShareButton:(UIButton *)btn
{
    if (self.PhotoBrowserShareButtonClick) {
        self.PhotoBrowserShareButtonClick(btn);
    }
}
@end
