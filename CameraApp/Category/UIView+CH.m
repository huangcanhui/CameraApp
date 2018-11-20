//
//  UIView+CH.m
//  CameraApp
//
//  Created by aieffei on 2018/11/20.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "UIView+CH.h"

@implementation UIView (CH)

- (CGFloat) ch_height
{
    return self.bounds.size.height ;
}
- (CGFloat) ch_width
{
    return self.bounds.size.width ;
}
- (CGFloat) ch_left
{
    return self.frame.origin.x ;
}
- (CGFloat) ch_right
{
    return CGRectGetMaxX(self.frame);
}
- (CGFloat) ch_top
{
    return self.frame.origin.y ;
}
- (CGFloat) ch_bottom
{
    return CGRectGetMaxY(self.frame);
}

- (void)setCh_top:(CGFloat)ch_top
{
    CGRect frame = self.frame ;
    frame.origin.y = ch_top ;
    self.frame = frame ;
}

- (void)setCh_left:(CGFloat)ch_left
{
    CGRect frame = self.frame ;
    frame.origin.x = ch_left ;
    self.frame = frame ;
}

- (void)setCh_right:(CGFloat)ch_right
{
    CGRect frame = self.frame ;
    frame.origin.x = ch_right ;
    self.frame = frame ;
}

- (void)setCh_bottom:(CGFloat)ch_bottom
{
    CGRect frame = self.frame ;
    frame.origin.x = ch_bottom ;
    self.frame = frame ;

}

- (void)setCh_width:(CGFloat)ch_width
{
    CGRect frame = self.frame ;
    frame.size.width = ch_width ;
    self.frame = frame ;

}

- (void)setCh_height:(CGFloat)ch_height
{
    CGRect frame = self.frame ;
    frame.size.height = ch_height ;
    self.frame = frame ;
}

@end
