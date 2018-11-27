//
//  ShareManager.h
//  CameraApp
//
//  Created by aieffei on 2018/11/27.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WXApi.h>

NS_ASSUME_NONNULL_BEGIN
//分享类型的枚举
typedef NS_ENUM(NSInteger, shareType) {
    shareTypeInSession = 0, //分享到好友
    shareTypeInTimeLine , //分享到朋友圈
};

@interface ShareManager : NSObject<WXApiDelegate>

+ (instancetype)shareInstance;
/**
 *  处理打开的分享Url，只是简单包装
 *  @param url 回调url
 *  @return 是否处理成功
 */
+ (BOOL)handleOpenUrl:(NSURL *)url ;
+ (BOOL)handleOpenUrl:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation ;
/**
 * 分享的接口调用(文字和图片的分享)
 * @param type 分享的类型
 * @param content 标题
 * @param imageArray 分享的图片数组
 */
- (void)shareContentType:(shareType)type content:(NSString *)content imageArray:(NSArray *)imageArray;

@end

NS_ASSUME_NONNULL_END
