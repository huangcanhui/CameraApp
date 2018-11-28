//
//  CHPhotoLibraryListViewController.m
//  CameraApp
//
//  Created by aieffei on 2018/11/22.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CHPhotoLibraryListViewController.h"

#import "JQFMDB.h"
#import "Personal.h"
#import "PhotoTakeTimeMath.h"
#import "PhotoLibraryReusableHeaderView.h"
#import "CHPhotoLibraryViewController.h"
#import "CHBrowserBottomView.h"
#import "PhotoListCollectionViewCell.h"
#import "CHPhotoLibraryViewController.h"

@interface CHPhotoLibraryListViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
/**
 * UICollectionView
 */
@property (nonatomic, strong)UICollectionView *collectionView;
/**
 * UICollectionViewFlowLayout
 */
@property (nonatomic, strong)UICollectionViewFlowLayout *flowLayout;
/**
 * 数据源
 */
@property (nonatomic, strong)NSArray *dataSource;
/**
 * 底部分享视图
 */
@property (nonatomic, strong)CHBrowserBottomView *bottomView;
/**
 * 是否允许编辑状态
 */
@property (nonatomic, assign)BOOL isAllowEdit;
/**
 * 移除的图片数据
 */
@property (nonatomic, strong)NSMutableArray *removeArrayM;

@end

@implementation CHPhotoLibraryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = HexColor(0x101010);
    
    self.navigationItem.title = @"我的图库";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"选择" style:UIBarButtonItemStyleDone target:self action:@selector(clickEditButton:)];
    
    self.isAllowEdit = NO;
    
    self.removeArrayM = [NSMutableArray array];
    
    [self createCollectionView];
}

#pragma mark - UICollectionView
- (void)createCollectionView
{
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.flowLayout];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.allowsMultipleSelection = YES;
    
    [self.view addSubview:self.collectionView];
    
    //注册头尾视图和cell
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"imageList"];
    [self.collectionView registerClass:[PhotoListCollectionViewCell class] forCellWithReuseIdentifier:@"imageList"];
    [self.collectionView registerClass:[PhotoLibraryReusableHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:PhotoLibraryReusableHeaderViewIdentifier];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *array = self.dataSource[section];
    return array.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataSource.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat itemW = (SCREEN_WIDTH - 40) / 4;
    return CGSizeMake(itemW, itemW);
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    return CGSizeMake(SCREEN_WIDTH, 10);
//}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, 40);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    PhotoLibraryReusableHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:PhotoLibraryReusableHeaderViewIdentifier forIndexPath:indexPath];
    NSArray *array = self.dataSource[indexPath.section];
    Personal *person = array[0];
    header.person = person;
    header.count = array.count;
    return header;
}

//item的垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

//item的水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageList" forIndexPath:indexPath];
    Personal *person = self.dataSource[indexPath.section][indexPath.row];
    cell.person = person;
    if (self.isAllowEdit == NO) {
        cell.isSelect = NO;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Personal *person = self.dataSource[indexPath.section][indexPath.row];
    if (self.isAllowEdit == YES) {
        PhotoListCollectionViewCell *cell = (PhotoListCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        cell.isSelect = YES;
        [self.removeArrayM addObject:person.photoTime];
    } else {
        CHPhotoLibraryViewController *photoVc = [CHPhotoLibraryViewController new];
        photoVc.type = enterTypeOnPhotoLibrary;
        photoVc.moment = person.photoTime;
        photoVc.reloadViewController = ^{
            
        };
        [self.navigationController pushViewController:photoVc animated:YES];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isAllowEdit == YES) {
        PhotoListCollectionViewCell *cell = (PhotoListCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        cell.isSelect = NO;
        Personal *person = self.dataSource[indexPath.section][indexPath.row];
        for (NSString *time in self.removeArrayM) {
            if ([person.photoTime isEqualToString:time]) {
                [self.removeArrayM removeObject:time];
                NSLog(@"将要移除:%@", self.removeArrayM);
                break;
            }
        }

    }
}

#pragma mark - 编辑按钮的点击事件
- (void)clickEditButton:(UIBarButtonItem *)btn
{
    if ([btn.title isEqualToString:@"选择"]) { //选择功能
        [btn setTitle:@"取消"];
        self.isAllowEdit = YES;
        [self rightBarButtonItemEdit];
    } else { //取消功能
        [btn setTitle:@"选择"];
        self.isAllowEdit = NO;
        [self rightBarButtonItemCancel];
    }
    [self.collectionView reloadData];
}

#pragma mark 导航栏右侧按钮的选择事件
- (void)rightBarButtonItemEdit
{
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, -kTabBarHeight, 0);
    
    self.bottomView = [[CHBrowserBottomView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - kTabBarHeight - kTopHeight, SCREEN_WIDTH, kTabBarHeight)];
    weakSelf(wself);
    self.bottomView.PhotoBrowserDeleteButtonClick = ^(CHBottomButton *btn) {
        if (self.removeArrayM.count >= 1) {
            [wself AlertWithTitle:@"删除确认" message:[NSString stringWithFormat:@"确认删除这%ld张图片?", wself.removeArrayM.count] andOthers:@[@"取消", @"确认"] animated:YES action:^(NSInteger index) {
                if (index == 1) {
                    [wself removePhotosOnDatabase];
                }
            }];
        } else {
            [wself AlertWithTitle:@"温馨提示" message:@"请至少选择一张照片" andOthers:@[@"确认"] animated:YES action:^(NSInteger index) {
                
            }];
        }
    };

    self.bottomView.PhotoBrowserShareTimeLineButtonClick = ^(CHBottomButton *btn) {
        [MBProgressHUD showErrorMessage:@"朋友圈"];
    };
    
    self.bottomView.PhotoBrowserShareSessionButtonClick = ^(CHBottomButton *btn) {
        [MBProgressHUD showInfoMessage:@"好友"];
    };
    [self.view addSubview:self.bottomView];
}

#pragma mark - 移除数据库中的数据
- (void)removePhotosOnDatabase
{
    JQFMDB *db = [JQFMDB shareDatabase];
    for (NSString *time in self.removeArrayM) {
        NSString *sql = [NSString stringWithFormat:@"WHERE photoTime = (SELECT max(%@) FROM user)", time];
        [db jq_deleteTable:@"user" whereFormat:sql];
    }
    [self.removeArrayM removeAllObjects];
    self.dataSource = nil;
    [self.collectionView reloadData];
    
}

#pragma mark 导航栏右侧按钮的取消事件
- (void)rightBarButtonItemCancel
{
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, kTabBarHeight, 0);
    [self.bottomView removeFromSuperview];
}

- (NSArray *)dataSource
{
    if (!_dataSource) {
        JQFMDB *db = [JQFMDB shareDatabase];
        NSArray *array = [db jq_lookupTable:@"user" dicOrModel:[Personal class] whereFormat:nil];
        PhotoTakeTimeMath *takeObject = [[PhotoTakeTimeMath alloc] init];
        _dataSource = [takeObject arrayComponentToObjectAndSoryBYTime:array];
    }
    return _dataSource;
}

@end
