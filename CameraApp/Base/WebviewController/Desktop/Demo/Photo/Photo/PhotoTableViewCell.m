//
//  AFNetManager.m
//  Cybespoke
//
//  Created by pengpeng on 15/10/8.
//  Copyright © 2015年 pengpeng. All rights reserved.
//

#import "PhotoTableViewCell.h"

@implementation PhotoTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.LblUserName setTextColor:[UIColor colorWithRed:69.0f / 255.0f green:69.0f / 255.0f blue:69.0f / 255.0f alpha:1]];
    [self.LblHeightWeight setTextColor:[UIColor colorWithRed:69.0f / 255.0f green:69.0f / 255.0f blue:69.0f / 255.0f alpha:1]];
    [self.LblState setTextColor:[UIColor colorWithRed:69.0f / 255.0f green:69.0f / 255.0f blue:69.0f / 255.0f alpha:1]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end