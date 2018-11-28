//
//  CHTipsViewController.m
//  CameraApp
//
//  Created by aieffei on 2018/11/21.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CHTipsViewController.h"

#import "CHTakePhotoViewModel.h"
#import "TipsModel.h"

@interface CHTipsViewController ()<UIScrollViewDelegate>
/**
 * 数据源
 */
@property (nonatomic, strong)NSArray *dataSource;
/**
 * UIScrollView
 */
@property (nonatomic, strong)UIScrollView *scrollView;
/**
 * UIPageControl
 */
@property (nonatomic, strong)UIPageControl *pageControl;
@end

@implementation CHTipsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = HexColor(0xffffff);
    
    self.navigationItem.title = @"拍房技巧";
    
    [self addPictureView];
}

- (void)addPictureView
{
    for (int i = 0; i < self.dataSource.count; i++) {
        UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(8 + SCREEN_WIDTH * i, 8, SCREEN_WIDTH - 16, kRealValue(192))];
        TipsModel *model = self.dataSource[i];
        imageView1.image = [UIImage imageNamed:model.photo[0]];
        imageView1.contentMode = UIViewContentModeScaleAspectFit;
        [self.scrollView addSubview:imageView1];
        
        UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(8 + SCREEN_WIDTH * i, imageView1.ch_bottom + 8, SCREEN_WIDTH - 16, kRealValue(192))];
        imageView2.image = [UIImage imageNamed:model.photo[1]];
        imageView2.contentMode = UIViewContentModeScaleAspectFit;
        [self.scrollView addSubview:imageView2];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8 + SCREEN_WIDTH * i, imageView2.ch_bottom + 8, SCREEN_WIDTH - 16, kRealValue(25))];
        titleLabel.text = model.title;
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.textColor = HexColor(0xffffff);
        titleLabel.font = [UIFont systemFontOfSize:20];
        [self.scrollView addSubview:titleLabel];
        
        
        UILabel *memoLabel = [[UILabel alloc] initWithFrame:CGRectMake(8 + SCREEN_WIDTH * i, titleLabel.ch_bottom + 8, SCREEN_WIDTH - 16, kRealValue(80))];
        memoLabel.text = model.memo;
        memoLabel.textColor = HexColor(0xffffff);
        memoLabel.textAlignment = NSTextAlignmentLeft;
        memoLabel.font = [UIFont systemFontOfSize:14];
        memoLabel.numberOfLines = 0;
        [self.scrollView addSubview:memoLabel];
    }
    [self.view addSubview:self.pageControl];
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - kTopHeight - kTabBarHeight, SCREEN_WIDTH, 30)];
        _pageControl.numberOfPages = self.dataSource.count;
        _pageControl.currentPage = 0;
        _pageControl.currentPageIndicatorTintColor = [UIColor purpleColor];
        _pageControl.pageIndicatorTintColor = HexColor(0xf0f0f0);
        _pageControl.userInteractionEnabled = NO; //不让用户进行点击
    }
    return _pageControl;
}


- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kTopHeight)];
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * (self.dataSource.count + 1), SCREEN_HEIGHT - kTopHeight);
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.backgroundColor = HexColor(0x101010);
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollviewW =  scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    int page = (x + scrollviewW / 2) /  scrollviewW;
    self.pageControl.currentPage = page;
    if (page > 7) {
        self.pageControl.currentPage = 0;
        self.scrollView.contentOffset = CGPointMake(-SCREEN_WIDTH, 0);
    }
}

- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [CHTakePhotoViewModel takePhotoAdvanceWithPlist];
    }
    return _dataSource;
}

- (void)dealloc
{
    [self.scrollView removeFromSuperview];
    self.dataSource = nil;
    [self.pageControl removeFromSuperview];
    NSLog(@"拍房技巧页面释放了");
}

@end
