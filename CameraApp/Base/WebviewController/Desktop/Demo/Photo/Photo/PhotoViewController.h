//
//  PhotoViewController.h
//  Photo
//
//  Created by 杨忠军 on 15/10/11.
//  Copyright © 2015年 cybespoke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@interface PhotoViewController : UIViewController

@property(nonatomic, retain) User *user;

@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbHeight;
@property (weak, nonatomic) IBOutlet UILabel *lbWeight;
@property (weak, nonatomic) IBOutlet UILabel *lbPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *tfUserName;
@property (weak, nonatomic) IBOutlet UITextField *tfHeight;
@property (weak, nonatomic) IBOutlet UITextField *tfWeight;
@property (weak, nonatomic) IBOutlet UITextField *tfPhoneNumber;

@property (weak, nonatomic) IBOutlet UIImageView *v1Img1;
@property (weak, nonatomic) IBOutlet UIButton *v1BtnTake;


@property (weak, nonatomic) IBOutlet UILabel *v2Label;
@property (weak, nonatomic) IBOutlet UIButton *v2BtnRetake;
@property (weak, nonatomic) IBOutlet UIImageView *v2Img1;
@property (weak, nonatomic) IBOutlet UIImageView *v2Img2;
@property (weak, nonatomic) IBOutlet UIImageView *v2Img3;


@property (weak, nonatomic) IBOutlet UIButton *reTakePhoto;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
@property (weak, nonatomic) IBOutlet UITextView *textView;



- (IBAction)takePhotos:(id)sender;
- (IBAction)reTakePhotos:(id)sender;

@end
