//
//  AFNetManager.m
//  Cybespoke
//
//  Created by pengpeng on 15/10/8.
//  Copyright © 2015年 pengpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *LblUserName;
@property (weak, nonatomic) IBOutlet UILabel *LblState;
@property (weak, nonatomic) IBOutlet UILabel *LblHeightWeight;

@property (weak, nonatomic) IBOutlet UIImageView *ImgFront;
@property (weak, nonatomic) IBOutlet UIImageView *ImgSide;
@property (weak, nonatomic) IBOutlet UIImageView *ImgBackground;

@end
