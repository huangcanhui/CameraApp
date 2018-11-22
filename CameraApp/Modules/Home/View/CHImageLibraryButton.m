//
//  CHImageLibraryButton.m
//  CameraApp
//
//  Created by aieffei on 2018/11/22.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CHImageLibraryButton.h"

@interface CHImageLibraryButton()
@property (nonatomic, strong)CHImageLibraryButton *imageButton;
@end

@implementation CHImageLibraryButton

+ (CHImageLibraryButton *)buttonWithFrame:(CGRect)frame type:(UIButtonType)type andBlock:(myBlock)block
{
    CHImageLibraryButton *button = [CHImageLibraryButton buttonWithType:type];
    button.frame = frame;
    button.imageButton = button;
    button.backgroundColor = KClearColor;
//    button.layer.borderWidth = 1;
//    button.layer.borderColor = KWhiteColor.CGColor;
    [button setImage:[UIImage imageWithData:button.imageData] forState:UIControlStateNormal];
    button.layer.cornerRadius = frame.size.width / 2;
    
    [button addTarget:button action:@selector(clickImageLibraryButton:) forControlEvents:UIControlEventTouchUpInside];
    
    button.block = block;
    
    return button;
}

- (void)clickImageLibraryButton:(CHImageLibraryButton *)button
{
    //执行外部传进来的block
    button.block(button);
}

- (void)setImageData:(NSData *)imageData
{
    _imageData = imageData;
    _imageData = imageData ? imageData : nil;
    [_imageButton setImage:[UIImage imageWithData:_imageData] forState:UIControlStateNormal];
}
@end
