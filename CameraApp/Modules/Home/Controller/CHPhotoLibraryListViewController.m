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

@end

@implementation CHPhotoLibraryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = HexColor(0x0f0f0f);
    
    self.navigationItem.title = @"我的图库";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"选择" style:UIBarButtonItemStyleDone target:self action:@selector(clickEditButton)];
    
    [self createCollectionView];
}

#pragma mark - UICollectionView
- (void)createCollectionView
{
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.flowLayout];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.view addSubview:self.collectionView];
    
    //注册头尾视图和cell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"imageList"];
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
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageList" forIndexPath:indexPath];
    Personal *person = self.dataSource[indexPath.section][indexPath.row];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:person.photoData]];
    cell.backgroundView = imageView;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了%ld-%ld", indexPath.section, (long)indexPath.row);
}



#pragma mark - 编辑按钮的点击事件
- (void)clickEditButton
{
    [MBProgressHUD showErrorMessage:@"逻辑还未实现"];
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
