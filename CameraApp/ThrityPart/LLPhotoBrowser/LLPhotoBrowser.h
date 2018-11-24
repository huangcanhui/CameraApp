//
//  LLPhotoBrowser.h
//  LLPhotoBrowser
//
//  Created by zhaomengWang on 17/2/6.
//  Copyright © 2017年 MaoChao Network Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LLPhotoBrowserDelegate;

@interface LLPhotoBrowser : UIViewController

@property (nonatomic, weak) id<LLPhotoBrowserDelegate> delegate;

- (instancetype)initWithImages:(NSArray<UIImage *> *)images currentIndex:(NSInteger)currentIndex;

@end

@protocol LLPhotoBrowserDelegate <NSObject>

@optional
/**
 * 点击保存按钮触发的事件
 */
- (void)photoBrowser:(LLPhotoBrowser *)photoBrowser didSelectImage:(id)image;
/**
 * 滑动到第几张
 */
- (void)photoBrowserScrollViewDidScrollViewWithIndex:(NSInteger)index;

@end
