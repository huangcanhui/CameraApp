//
//  PhotoListCollectionViewCell.m
//  CameraApp
//
//  Created by aieffei on 2018/11/27.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "PhotoListCollectionViewCell.h"

@interface PhotoListCollectionViewCell ()
/**
 * 选中的图片
 */
@property (nonatomic, strong)UIImageView *selectImageView;
/**
 * 图片
 */
@property (nonatomic, strong)UIImageView *imageView;

@end

@implementation PhotoListCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCellUI];
    }
    return self;
}

- (void)initCellUI
{
    UIImageView *photoImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.imageView = photoImageView;
    [self addSubview:photoImageView];
    
    self.selectImageView = [[UIImageView alloc] initWithFrame:CGRectMake(photoImageView.ch_width - 20, photoImageView.ch_height - 20, 20, 20)];
    self.selectImageView.image = [UIImage imageNamed:@"album_edit_icon_choose"];
    self.selectImageView.hidden = YES;
    [photoImageView addSubview:self.selectImageView];
}

- (void)setPerson:(Personal *)person
{
    _person = person ? person : nil;
    self.imageView.image = [UIImage imageWithData:_person.photoData];
}

- (void)setIsSelect:(BOOL)isSelect
{
    _isSelect = isSelect ? isSelect : NO;
    
    if (_isSelect == YES) {
        self.selectImageView.hidden = NO;
    } else {
        self.selectImageView.hidden = YES;
    }

}

@end
