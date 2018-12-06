//
//  NSNumber+mySort.m
//  CameraApp
//
//  Created by aieffei on 2018/12/6.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "NSNumber+mySort.h"

@implementation NSNumber (mySort)

- (NSComparisonResult)mySort:(NSNumber *)num {
    
    if (self == num) {
        return NSOrderedSame;
    } else if (self > num) {
        // 当自身大于num时, 本应该返回 NSOrderedDescending , 这里反转其结果, 使返回 NSOrderedAscending
        return NSOrderedAscending;
    }else {
        return NSOrderedDescending;
    }
}

@end
