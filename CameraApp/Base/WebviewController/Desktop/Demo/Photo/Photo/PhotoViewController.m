//
//  AFNetManager.m
//  Cybespoke
//
//  Created by pengpeng on 15/10/8.
//  Copyright © 2015年 pengpeng. All rights reserved.
//

#import "PhotoViewController.h"
#import <CoreMotion/CoreMotion.h>
#import "PhotoDBManger.h"
#import "AFNetManager.h"


//用宏定义label的尺寸位置
#define LabelX backgroundView.center.x / 16 - 5
#define LeftLabelY  backgroundView.center.y
#define DownLabelX  backgroundView.center.x - 10
#define DownLabelY  LeftLabelY * 1.93

@interface PhotoViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    
    UIImagePickerController *imagePickerController;
    NSInteger currentStep;
    NSArray *backgroundImages;
    
    CMMotionManager *motionManager;
    UILabel *leftLabel;
    UILabel *downLabel;
    
    PhotoDBManger *dbManager;
    UIBarButtonItem *rightBtn;
    UIBarButtonItem *leftBtn;
    
    UIButton *shutButton;
    UIButton *retakeButton;
    //设置成全局变量的backgroundView
    UIImageView *backgroundView;
    
    UIImageView *backImageView;
    
}
@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.v2Label.font = [UIFont fontWithName:@"黑体" size:18];
    
    [self.lbName setTextColor:[UIColor colorWithRed:69.0f / 255.0f green:69.0f / 255.0f blue:69.0f / 255.0f alpha:1]];
    [self.lbHeight setTextColor:[UIColor colorWithRed:69.0f / 255.0f green:69.0f / 255.0f blue:69.0f / 255.0f alpha:1]];
    [self.lbWeight setTextColor:[UIColor colorWithRed:69.0f / 255.0f green:69.0f / 255.0f blue:69.0f / 255.0f alpha:1]];
    [self.lbPhoneNumber setTextColor:[UIColor colorWithRed:69.0f / 255.0f green:69.0f / 255.0f blue:69.0f / 255.0f alpha:1]];
    
    [self.tfUserName setTextColor:[UIColor colorWithRed:69.0f / 255.0f green:69.0f / 255.0f blue:69.0f / 255.0f alpha:1]];
    [self.tfHeight setTextColor:[UIColor colorWithRed:69.0f / 255.0f green:69.0f / 255.0f blue:69.0f / 255.0f alpha:1]];
    [self.tfWeight setTextColor:[UIColor colorWithRed:69.0f / 255.0f green:69.0f / 255.0f blue:69.0f / 255.0f alpha:1]];
    [self.tfPhoneNumber setTextColor:[UIColor colorWithRed:69.0f / 255.0f green:69.0f / 255.0f blue:69.0f / 255.0f alpha:1]];
    
 
    
    //设置四个uitextFiled 代理回调
    self.tfUserName.delegate = self;
    self.tfHeight.delegate   = self;
    self.tfPhoneNumber.delegate = self;
    self.tfWeight.delegate   = self;
    
    //设置重新拍摄的样式
    self.reTakePhoto.backgroundColor   = [UIColor colorWithRed:219.0f / 255.0f green:48.0f / 255.0f blue:40.0f / 255.0f alpha:1];
    [self.reTakePhoto.layer setCornerRadius:5];
    //设置拍照量体button的样式
    self.v1BtnTake.layer.backgroundColor = [UIColor colorWithRed:214.0 / 255.0 green:27.0 / 255.0 blue:32.0 / 255.0 alpha:1].CGColor;
    
    dbManager = [PhotoDBManger manager];
    // Do any additional setup after loading the view
    if (self.user == nil) {
        self.user = [[User alloc] init];
        [self setVisiable:@"v1"];
    }
    else{
        [self.tfUserName setText:self.user.userName];
        [self.tfHeight setText:[NSString stringWithFormat:@"%ld", (long)self.user.height]];
        [self.tfWeight setText:[NSString stringWithFormat:@"%0.1f", self.user.weight]];
        [self.tfPhoneNumber setText:self.user.phoneNum];
        
        [self.v2Img1 setImage:[UIImage imageWithContentsOfFile:self.user.frontPath]];
        [self.v2Img2 setImage:[UIImage imageWithContentsOfFile:self.user.sidePath]];
        [self.v2Img3 setImage:[UIImage imageWithContentsOfFile:self.user.backgroundPath]];
        [self setVisiable:@"v2"];
    }
    [self.navigationItem setTitle:@"新建拍照"];
    rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(uploadData:)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    //设置返回按钮的样式
    [self.navigationController.navigationItem setHidesBackButton:YES];
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    left.frame     = CGRectMake(0, 10, 20, 20);
    [left setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [left addTarget:self action:@selector(backToPhotoVC) forControlEvents:UIControlEventTouchUpInside];
    leftBtn = [[UIBarButtonItem alloc]initWithCustomView:left];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    backgroundImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"liangti-camera-front"], [UIImage imageNamed:@"liangti-camera-side"], [UIImage imageNamed:@"liangti-camera-back"], nil];
    
    // Do any additional setup after loading the view.
    [self.indicatorView setHidden:YES];
    
    
    
}


//添加一个点击每一个图片放大的效果

-(void)addGestureOnImageViewToEnlargeImage:(UIImageView *)imgView
{
    
}

#pragma ---mark 弹回键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma --mark 返回PhotoViewController
-(void)backToPhotoVC
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - 上传数据
- (void)uploadData:(id)sender
{
    
    if (self.tfUserName.text.length < 1 || self.tfHeight.text.length < 1 || self.tfPhoneNumber.text.length < 1 || self.tfWeight.text.length < 1 ||  !self.v2Img1.image || !self.v2Img2.image || !self.v2Img3.image ) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请完善您的个人信息后再提交" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        [alert  show];
        
    }
    else{
        if (self.user.state) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"通知"
                                                                       message:@"数据已上传，不能重复提交！"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                                            handler:^(UIAlertAction * action) {

                                                                        }];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
        else{
            
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择数据处理方式" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancel  = [UIAlertAction actionWithTitle:@"上传到服务器" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                    self.user.userName = self.tfUserName.text;
                    self.user.height   = [self.tfHeight.text integerValue];
                    self.user.weight   = [self.tfWeight.text floatValue];
                    self.user.phoneNum = self.tfPhoneNumber.text;
                    [self.indicatorView setHidden:NO];
                    [self.indicatorView startAnimating];
                    
                    [AFNetManager uploadUserData:self.user success:^(id data) {
                        
                        [self.indicatorView stopAnimating];
                        [self.indicatorView setHidden:YES];
                        self.user.state = YES;
                        [dbManager saveUser:self.user];
                        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"通知"
                                                                                       message:@"数据成功上传！"
                                                                                preferredStyle:UIAlertControllerStyleAlert];
                        
                        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                                              handler:^(UIAlertAction * action) {
                                                                                  [self.navigationController popViewControllerAnimated:YES];
                                                                              }];
                        [alert addAction:defaultAction];
                        [self presentViewController:alert animated:YES completion:nil];
                        
                    } fail:^(NSError *error) {
                        [self.indicatorView stopAnimating];
                        [self.indicatorView setHidden:YES];
                        self.user.state = NO;
                        [dbManager saveUser:self.user];
                        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"通知"
                                                                                       message:@"数据上传失败，已在本地保存！"
                                                                                preferredStyle:UIAlertControllerStyleAlert];
                        
                        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                                              handler:nil];
                        [alert addAction:defaultAction];
                        [self presentViewController:alert animated:YES completion:nil];
                    }];
                    
                }];

                UIAlertAction *ok      = [UIAlertAction actionWithTitle:@"保存在本地" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
                    self.user.state = NO;
                    self.user.userName = self.tfUserName.text;
                    self.user.height   = [self.tfHeight.text integerValue];
                    self.user.weight   = [self.tfWeight.text floatValue];
                    self.user.phoneNum = self.tfPhoneNumber.text;
                    [dbManager saveUser:self.user];
                
                }];
                [alertVC addAction:cancel];
                [alertVC addAction:ok];
                [self presentViewController:alertVC animated:YES completion:nil];
                
            } else {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请选择数据处理方式" delegate:self cancelButtonTitle:@"上传到服务器" otherButtonTitles:@"保存在本地", nil];
                [alert show];
            }
         }
    }
}

//提示保存到本地还是上传到服务器
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex) {
        
        self.user.state = NO;
        self.user.userName = self.tfUserName.text;
        self.user.height   = [self.tfHeight.text integerValue];
        self.user.weight   = [self.tfWeight.text floatValue];
        self.user.phoneNum = self.tfPhoneNumber.text;
        [dbManager saveUser:self.user];

    }
    else
    {
        self.user.userName = self.tfUserName.text;
        self.user.height   = [self.tfHeight.text integerValue];
        self.user.weight   = [self.tfWeight.text floatValue];
        self.user.phoneNum = self.tfPhoneNumber.text;
        [self.indicatorView setHidden:NO];
        [self.indicatorView startAnimating];
        
        [AFNetManager uploadUserData:self.user success:^(id data) {
            
            [self.indicatorView stopAnimating];
            [self.indicatorView setHidden:YES];
            self.user.state = YES;
            [dbManager saveUser:self.user];
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"通知"
                                                                           message:@"数据成功上传！"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {
                                                                      [self.navigationController popViewControllerAnimated:YES];
                                                                  }];
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            
        } fail:^(NSError *error) {
            [self.indicatorView stopAnimating];
            [self.indicatorView setHidden:YES];
            self.user.state = NO;
            [dbManager saveUser:self.user];
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"通知"
                                                                           message:@"数据上传失败，已在本地保存！"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                                  handler:nil];
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        }];

    }
}

- (void)setVisiable:(NSString *)name
{
    if ([name isEqualToString:@"v1"]) {
        self.v1Img1.hidden = NO;
        self.v1BtnTake.hidden = NO;
        
        self.v2Label.hidden = YES;
        self.v2BtnRetake.hidden = YES;
        self.v2Img1.hidden = YES;
        self.v2Img2.hidden = YES;
        self.v2Img3.hidden = YES;
    }
    else{
        self.v1Img1.hidden = YES;
        self.v1BtnTake.hidden = YES;
        
        self.v2Label.hidden = NO;
        self.v2BtnRetake.hidden = NO;
        self.v2Img1.hidden = NO;
        self.v2Img2.hidden = NO;
        self.v2Img3.hidden = NO;

        if (self.user.state) {
            [self.v2BtnRetake setEnabled:NO];
            [self.tfUserName setEnabled: NO];
            [self.tfHeight setEnabled:NO];
            [self.tfWeight setEnabled:NO];
            [self.tfPhoneNumber setEnabled:NO];
        }
    }
}

- (IBAction)takePhotos:(id)sender {
    
    currentStep = 1;
    
    imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.delegate   = self;
    
    imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    
    backgroundView = [[UIImageView alloc] initWithImage:backgroundImages[currentStep - 1]];;
    [backgroundView setFrame:CGRectMake(0, 0, imagePickerController.view.frame.size.width, imagePickerController.view.frame.size.height - 100)];
    [imagePickerController.view addSubview:backgroundView];
    //[backgroundView setFrame:imagePickerController.view.frame];
    //imagePickerController.cameraOverlayView = backgroundView;
    
    [self createCoreMotionOnCameraView];
    
    [self presentViewController:imagePickerController animated:YES completion:^{
       [self createMoveLabelWithTheGravityInCaremaView];
        
        
    }];
}

- (IBAction)reTakePhotos:(id)sender {
    
    [leftLabel setHidden:NO];
    [downLabel setHidden:NO];
    [self takePhotos:sender];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    UIImage* img = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    NSString *uuid = [[NSUUID UUID] UUIDString];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *filePath = [docDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg", uuid]];
    NSData *imgData = UIImageJPEGRepresentation(img, 0.2);
    
    [imgData writeToFile:filePath atomically:YES];
    
    switch (currentStep) {
        case 1:
            self.user.frontPath = filePath;
            break;
        case 2:
            self.user.sidePath  = filePath;
            break;
        case 3:
            self.user.backgroundPath = filePath;
            break;
        default:
            break;
    }
    
    [imagePickerController dismissViewControllerAnimated:NO completion:nil];
    
    if (currentStep < 3) {
        imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.delegate   = self;
        imagePickerController.allowsEditing = NO;
        imagePickerController.cameraDevice      = UIImagePickerControllerCameraDeviceRear;
        currentStep++;
        
        backgroundView = [[UIImageView alloc] initWithImage:backgroundImages[currentStep - 1]];;
        [backgroundView setFrame:CGRectMake(0, 0, imagePickerController.view.frame.size.width, imagePickerController.view.frame.size.height - 100)];
        [imagePickerController.view addSubview:backgroundView];
        //[backgroundView setFrame:imagePickerController.view.frame];
        //imagePickerController.cameraOverlayView = backgroundView;
        [self createCoreMotionOnCameraView];
        [self presentViewController:imagePickerController animated:YES completion:^{
            [self createMoveLabelWithTheGravityInCaremaView];
        }];
    }
    else{
        [self setVisiable:@"v2"];
        [self.v2Img1 setImage:[UIImage imageWithContentsOfFile:self.user.frontPath]];
        [self.v2Img2 setImage:[UIImage imageWithContentsOfFile:self.user.sidePath]];
        [self.v2Img3 setImage:[UIImage imageWithContentsOfFile:self.user.backgroundPath]];
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 陀螺仪定位

-(void)createMoveLabelWithTheGravityInCaremaView
{
    leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(LabelX,LeftLabelY,10,20)];
    leftLabel.layer.cornerRadius = 5;
    leftLabel.clipsToBounds      = YES;
    leftLabel.backgroundColor    = [UIColor blueColor];
    [imagePickerController.view addSubview:leftLabel];
    
    downLabel = [[UILabel alloc]initWithFrame:CGRectMake(DownLabelX,DownLabelY,20,10)];
    downLabel.layer.cornerRadius = 5;
    downLabel.clipsToBounds      = YES;
    downLabel.backgroundColor    = [UIColor blueColor];
    [imagePickerController.view addSubview:downLabel];
    
    UIImageView *hahaImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 30, self.view.frame.size.height / 2 - 30, 60, 60)];
    hahaImageView.image = [UIImage imageNamed:@"1"];
    [imagePickerController.view addSubview:hahaImageView];
    
    backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 15, self.view.frame.size.height / 2 - 15, 30, 30)];
    backImageView.image = [UIImage imageNamed:@"2"];
    [imagePickerController.view addSubview:backImageView];
    
}

-(void)createCoreMotionOnCameraView
{
    motionManager = [[CMMotionManager alloc] init];
    if (motionManager.deviceMotionAvailable) {
        
        motionManager.deviceMotionUpdateInterval = 0.1f;
        [motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
            
            //前后摇晃时候与Y轴的夹角
            double fTheta = atan2(motion.gravity.z, sqrt(motion.gravity.x * motion.gravity.x + motion.gravity.y * motion.gravity.y)) / M_PI * 180.0;
            //左右摇晃时与Y轴的夹角
            double yTheta = atan2(motion.gravity.x, sqrt(motion.gravity.z * motion.gravity.z + motion.gravity.y * motion.gravity.y)) / M_PI * 180.0;
            
            NSLog(@"前后:%f 左右:%f", fTheta, yTheta);
            [UIView animateWithDuration:1 animations:^{
                leftLabel.frame  = CGRectMake(DownLabelX + yTheta * 5, LeftLabelY + fTheta * 5, 10, 20);
                downLabel.frame  = CGRectMake( DownLabelX + yTheta * 5, DownLabelY, 20, 10);
                
                backImageView.frame = CGRectMake(self.view.frame.size.width / 2 + yTheta * 5 - 15, self.view.frame.size.height / 2 - 15 + fTheta * 5, 30, 30);
            }];
            if (fTheta > -3 && fTheta < 3 && yTheta < 3 && yTheta > -3){
                [shutButton setHidden:NO];
            }
            else{
                [shutButton setHidden:YES];
            }
        }];
    }
}

#pragma ---mark camera界面产生时候调用此方法
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //首先判断当前设备的版本(主要是iOS9修改了camera界面底层的实现)
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
        //在相机界面中进行循环遍历出shutterButton
        NSLog(@"1:  %@", viewController.view.subviews);
        for (UIView *tmpView in viewController.view.subviews) {
            NSLog(@"2:   %@", tmpView.subviews);
            
            //删除拍照界面顶部的工具条 (iOS9之后设置topBar隐藏属性是不能够隐藏掉那个前置摄像头)
            if ([[[tmpView class]description]isEqualToString:@"CMKTopBar"]) {
                UIToolbar *topBar = (UIToolbar *)tmpView;
                [topBar removeFromSuperview];
            }
            //获取重拍按钮
            for (UIView *tmpView2 in tmpView.subviews) {
                if ( [[[tmpView2 class]description]isEqualToString:@"PLCropOverlayBottomBar"])
                {
                    for (UIView *tmpView3 in tmpView2.subviews) {
                        retakeButton = (UIButton *)tmpView3.subviews[0];
                        [retakeButton addTarget:self action:@selector(takePhotoAgain) forControlEvents:UIControlEventTouchUpInside];
                    }
                }
                //获取到拍照界面的按钮
                if ( [[[tmpView2 class]description]isEqualToString:@"CMKShutterButton"]) {
                shutButton = (UIButton *)tmpView2;
                [shutButton setHidden:YES];
                [shutButton addTarget:self action:@selector(setHiddenLabel) forControlEvents:UIControlEventTouchUpInside];
                }
            }
        }
    }
    else{
        //在相机界面中进行循环遍历出shutterButton
        for (UIView *tmpView in viewController.view.subviews) {
            
            //隐藏拍照界面顶部的工具条
            if ([[[tmpView class]description]isEqualToString:@"CAMTopBar"]) {
                UIToolbar *topBar = (UIToolbar *)tmpView;
                [topBar removeFromSuperview];
            }
            //获取到重拍按钮
            for (UIView *tmpView2 in tmpView.subviews) {
                
                if ( [[[tmpView2 class]description]isEqualToString:@"PLCropOverlayBottomBar"])
                {
                    for (UIView *tmpView3 in tmpView2.subviews) {
                        retakeButton = (UIButton *)tmpView3.subviews[0];
                        [retakeButton addTarget:self action:@selector(takePhotoAgain) forControlEvents:UIControlEventTouchUpInside];
                    }
                }
              //获取到拍照界面的按钮
                if ( [[[tmpView2 class]description]isEqualToString:@"CAMShutterButton"]) {
                shutButton = (UIButton *)tmpView2;
                [shutButton setHidden:YES];
                [shutButton addTarget:self action:@selector(setHiddenLabel) forControlEvents:UIControlEventTouchUpInside];
                }
            }
        }
    }
}
#pragma ---mark 重拍
-(void)takePhotoAgain
{
   
    [backgroundView setHidden:NO];
    
    [leftLabel setHidden:NO];
    [downLabel setHidden:NO];
}

#pragma --mark 隐藏两个label
-(void)setHiddenLabel
{
   
    [backgroundView setHidden:YES];
    
    [leftLabel setHidden:YES];
    [downLabel setHidden:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
