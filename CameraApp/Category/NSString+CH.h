//
//  NSString+CH.h
//  CameraApp
//
//  Created by aieffei on 2018/11/26.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface NSString (CH)
/**
 *  验证字符串是否为空
 *  " "都为空
 *  @return 空为真，不为空则返回假
 */
- (BOOL) isBlank;

/**
 *  验证字符串是否为空(新增这个方法主要为了解决，上一个对象方法，当对象为nil无法调用的问题)
 *  nil," "都为空
 *  @return 空为真，不为空则返回假
 */
+ (BOOL) isBlank:(NSString *)str;

/**
 *  验证手机号码是否合法
 *
 *  @return 通过返回YES，失败返回NO
 */
- (BOOL) validPhone;

/**
 *  验证邮箱是否合法
 *
 *  @return 通过返回YES，失败返回NO
 */
- (BOOL) validMail;

/**
 验证身份证号是否合法
 */
- (BOOL) vaildCardNo;

/**
 * 验证字符串是否是纯数字
 */
+ (BOOL)isPureNumandCharacters:(NSString *)string;

/**
 * 判断字符串是否是由数字和字母组成
 */
- (BOOL)vailCharacterAndNum;
@end

NS_ASSUME_NONNULL_END
