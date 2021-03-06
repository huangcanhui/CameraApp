//
//  PhotoLibraryReusableHeaderView.m
//  CameraApp
//
//  Created by aieffei on 2018/11/26.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "PhotoLibraryReusableHeaderView.h"
#import "PhotoTakeTimeMath.h"

@interface PhotoLibraryReusableHeaderView ()
//主标题
@property (nonatomic, strong)UILabel *titleLabel;
//副标题
@property (nonatomic, strong)UILabel *subTitle;
@property (nonatomic, strong)UILabel *timeTitle;
//选中按钮
@property (nonatomic, strong)UIButton *button;

@end

@implementation PhotoLibraryReusableHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)setCount:(NSInteger)count
{
    _count = count ? count : 0;
    
    _timeTitle.text = [NSString stringWithFormat:@"共%ld张", _count];
}

- (void)setPerson:(Personal *)person
{
    _person = person ? person : nil;
    
    _titleLabel.text = [[PhotoTakeTimeMath alloc] titleShowString:self.person.photoTime];
    
    _subTitle.text = [[PhotoTakeTimeMath alloc] subTitleWithTimestamp:self.person.photoTime];
}

- (void)initUI
{
    self.backgroundColor = HexColor(0x000000);
    CGFloat margin = 10;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, 0, SCREEN_WIDTH - 80, 25)];
    titleLabel.text = @"";
    _titleLabel = titleLabel;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.textColor = HexColor(0xffffff);
    [self addSubview:titleLabel];
    
    UILabel *timeTitle = [[UILabel alloc] initWithFrame:CGRectMake(margin, titleLabel.ch_bottom, 40, 15)];
    _timeTitle = timeTitle;
    timeTitle.text = @"";
    timeTitle.textAlignment = NSTextAlignmentLeft;
    timeTitle.font = [UIFont systemFontOfSize:11];
    timeTitle.textColor = HexColor(0xffffff);
    [self addSubview:timeTitle];

    
    UILabel *subTitle = [[UILabel alloc] initWithFrame:CGRectMake(timeTitle.ch_width + margin, titleLabel.ch_bottom, SCREEN_WIDTH - 80, 15)];
    _subTitle = subTitle;
    subTitle.text = @"";
    subTitle.textAlignment = NSTextAlignmentLeft;
    subTitle.font = [UIFont systemFontOfSize:11];
    subTitle.textColor = HexColor(0xffffff);
    [self addSubview:subTitle];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 0, 80, 40)];
    _button = btn;
    [btn setTitle:@"全选" forState:UIControlStateNormal];
    [btn setTitleColor:HexColor(0x007aff) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    btn.hidden = YES;
    [self addSubview:btn];
}

- (void)clickBtn:(UIButton *)btn
{
    if ([btn.titleLabel.text isEqualToString:@"全选"]) { //选中
        [btn setTitle:@"取消全选" forState:UIControlStateNormal];
        if (self.selectedAndUnselectedSection) {
            self.selectedAndUnselectedSection(YES, btn);
        }
    } else { //取消选中
        [btn setTitle:@"全选" forState:UIControlStateNormal];
        if (self.selectedAndUnselectedSection) {
            self.selectedAndUnselectedSection(NO, btn);
        }
    }
}

- (void)setIsShowButton:(BOOL)isShowButton
{
    _button.hidden = YES;
//    _isShowButton = isShowButton ? isShowButton : NO;
//    if (_isShowButton == YES) {
//        _button.hidden = NO;
//    } else {
//        _button.hidden = YES;
//    }
}

@end

NSString *const PhotoLibraryReusableHeaderViewIdentifier = @"PhotoLibraryReusableHeaderViewIdentifier";
