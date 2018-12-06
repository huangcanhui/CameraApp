//
//  ShareManager.h
//  CameraApp
//
//  Created by aieffei on 2018/11/27.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WXApiObject.h>

NS_ASSUME_NONNULL_BEGIN
//分享类型的枚举
typedef NS_ENUM(NSInteger, shareType) {
    shareTypeInSession = 0, //分享到好友
    shareTypeInTimeLine , //分享到朋友圈
};

@interface ShareManager : NSObject
/**
 * 微信分享的接口
 */
+ (BOOL)sendImageData:(NSData *)imageData TagName:(NSString *)tagName MessageExt:(NSString *)messageExt Action:(NSString *)action ThumbImage:(UIImage *)thumbImage InScene:(enum WXScene)scene;

/**
 *  处理打开的分享Url，只是简单包装
 *  @param url 回调url
 *  @return 是否处理成功
 */
+ (BOOL)handleOpenUrl:(NSURL *)url ;
+ (BOOL)handleOpenUrl:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation ;


@end

NS_ASSUME_NONNULL_END
