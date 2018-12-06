//
//  CHPhotoLibraryViewController.m
//  CameraApp
//
//  Created by aieffei on 2018/11/20.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CHPhotoLibraryViewController.h"
#import "JQFMDB.h"
#import "Personal.h"
#import "CHPhotoLibraryListViewController.h"
#import "CHBrowserBottomView.h"
#import "LLPhotoBrowser.h"
#import "ShareManager.h"
#import "WXApiManager.h"

@interface CHPhotoLibraryViewController ()<UIScrollViewDelegate, LLPhotoBrowserDelegate, WXApiManagerDelegate>
/**
 * 底部的视图
 */
@property (nonatomic, strong)CHBrowserBottomView *bottomView;
/**
 * 数据源
 */
@property (nonatomic, strong)NSArray *dataSource;
/**
 * 图片展示区
 */
@property (nonatomic, strong)UIView *picureView;
/**
 * 选中第几张
 */
@property (nonatomic, assign)NSInteger indexPicture;

@property (nonatomic, strong)LLPhotoBrowser *photoBrowser;
@end

@implementation CHPhotoLibraryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = HexColor(0x101010);
    
    self.navigationItem.title = @"图库";
    
    if (self.type == enterTypeOnCamera) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"所有图片" style:UIBarButtonItemStyleDone target:self action:@selector(popToPhotoLibrary)];
    }
    
    [self.view addSubview:self.picureView];
        
    [self.view addSubview:self.bottomView];
    
    [self lookupDataBase];
}

#pragma mark - 查找数据中
- (void)lookupDataBase
{
    [MBProgressHUD showActivityMessageInView:@"图片加载中，请稍后..."];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        JQFMDB *db = [JQFMDB shareDatabase];
        [self applyViewWithDataBase:[db jq_lookupTable:@"user" dicOrModel:[Personal class] whereFormat:nil]];
    });
     [MBProgressHUD hideHUD];
}

- (void)applyViewWithDataBase:(NSArray *)array
{
    NSMutableArray *arrayM = [NSMutableArray array];
    NSMutableArray *overArrayM = [NSMutableArray array];
    for (Personal *person in array) {
        [arrayM addObject:[UIImage imageWithData:person.photoData]];
        [overArrayM addObject:person.photoTime];
    }
    NSInteger index ;
    if (![self.moment isBlank]) {
        [overArrayM containsObject:self.moment];
        index = [overArrayM indexOfObject:self.moment];
    } else {
        index = arrayM.count - 1;
    }
    self.photoBrowser = [[LLPhotoBrowser alloc] initWithImages:[arrayM copy] currentIndex:index];
    self.photoBrowser.delegate = self;
    [self.picureView addSubview:self.photoBrowser.view];

    [self addChildViewController:self.photoBrowser];
    
    self.dataSource = [array copy];
    self.indexPicture = index;
   
}

- (void)photoBrowserScrollViewDidScrollViewWithIndex:(NSInteger)index
{
    self.indexPicture = index;
}

#pragma mark - 添加底部视图
- (CHBrowserBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[CHBrowserBottomView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - kTopHeight - kTabBarHeight, SCREEN_WIDTH, kTabBarHeight)];
        weakSelf(wself);
        _bottomView.PhotoBrowserDeleteButtonClick = ^(CHBottomButton * btn) {
            [wself deletePicture]; //删除照片
        };
        
        _bottomView.PhotoBrowserShareTimeLineButtonClick = ^(CHBottomButton *btn) {
            Personal *person = wself.dataSource[wself.indexPicture];
            [WXApiManager sharedManager].delegate = wself;
            [ShareManager sendImageData:person.photoData TagName:@"" MessageExt:@"" Action:@"" ThumbImage:[UIImage imageNamed:@"placehold"] InScene:WXSceneTimeline];
        };
        
        _bottomView.PhotoBrowserShareSessionButtonClick = ^(CHBottomButton *btn) {
            Personal *person = wself.dataSource[wself.indexPicture];
            [WXApiManager sharedManager].delegate = wself;
            [ShareManager sendImageData:person.photoData TagName:@"" MessageExt:@"" Action:@"" ThumbImage:[UIImage imageNamed:@"placehold"] InScene:WXSceneSession];
        };
    }
    return _bottomView;
}

- (void)managerDidRecvShowMessageReq:(ShowMessageFromWXReq *)request
{
    NSLog(@"微信发回的request:%@", request);
}

- (void)deletePicture
{
    NSString *tips;
    if (self.dataSource.count <= 1) { //如果视图中只剩下一张图片，则需要提示
        tips = @"这是图库中最后一张图片，确认删除?";
    } else {
        tips = @"执行此操作会将此照片从图库中删除";
    }
    [self ActionSheetWithTitle:tips message:@"" destructive:@"删除" destructiveAction:^(NSInteger index) {
        Personal *obj = self.dataSource[self.indexPicture];
        JQFMDB *db = [JQFMDB shareDatabase];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            for (Personal *person in self.dataSource) {
                if ([obj.photoTime isEqual:person.photoTime]) { //两个时间相等
                    NSString *sql = [NSString stringWithFormat:@"WHERE photoTime = (SELECT max(%@) FROM user)", person.photoTime];
                    [db jq_deleteTable:@"user" whereFormat:sql];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.photoBrowser.removeArray = @[[NSString stringWithFormat:@"%ld", self.indexPicture]];
                        self.indexPicture -= 1;
                    });
                }
            }
        });
        if (self.dataSource.count <= 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } andOthers:@[@"取消"] animated:YES action:^(NSInteger index) {
        
    }];
}


#pragma mark - 跳转到全部图片
- (void)popToPhotoLibrary
{
    CHPhotoLibraryListViewController *listVC = [CHPhotoLibraryListViewController new];
    [self.navigationController pushViewController:listVC animated:YES];
}

- (UIView *)picureView
{
    if (!_picureView) {
        _picureView = [[UIView alloc] initWithFrame:CGRectMake(0, -kTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kTabBarHeight)];
        _picureView.backgroundColor = KBlackColor;
    }
    return _picureView;
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (self.reloadViewController) {
        self.reloadViewController();
    }
}

@end
