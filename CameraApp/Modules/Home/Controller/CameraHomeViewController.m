//
//  CameraHomeViewController.m
//  CameraApp
//
//  Created by aieffei on 2018/11/20.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CameraHomeViewController.h"

#import "CHPhotoLibraryViewController.h"
#import "CHPhotoLibraryListViewController.h"
#import "CHTipsViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreMotion/CoreMotion.h>

#import "ImageObject.h"
#import "CHSpringView.h"
#import "CHTime.h"
#import "JQFMDB.h"
#import "Personal.h"
#import "CHImageLibraryButton.h"
#import "CHCompressImageManager.h"
#import "TakePhotoAlertView.h"
#import "CameraHomeViewController+AuthorizationAndLayer.h"

#ifdef DEBUG
#import "CameraHomeViewController+Debug_DevelopmentViewController.h"
#endif

@interface CameraHomeViewController ()

@property (nonatomic, strong)AVCaptureSession *captureSession; //负责输入和输出之间的数据传递
@property (nonatomic, strong)AVCaptureDeviceInput *captureDeviceInput; //负责从AVCaptureDevice获取输入数据
@property (nonatomic, strong)AVCaptureStillImageOutput *captureStillImageOutput; //照片输出流
@property (nonatomic, strong)AVCaptureVideoPreviewLayer *viewPreviewLayer; //相机拍摄预览层
@property (nonatomic, strong)CMMotionManager *motionManager; //水平仪管理类
@property (nonatomic, assign)UIDeviceOrientation deviceOrientation; //屏幕方向枚举
@property (nonatomic, assign)CGFloat deviceAngle; //手机的角度
@property (nonatomic, strong)CADisplayLink *displayLink;//定时器
@property (nonatomic, strong)CALayer *viewScopeLayer;//拍照水平线
@property (nonatomic, strong)UIView *viewContainer; //相机预览图层
@property (nonatomic, assign)BOOL needShowAssistantLine; //是否需要展示水平线
@property (nonatomic, strong)UIView *bottomView; //拍照按钮图层
@property (nonatomic, strong)UIButton *takePhotoButton;//拍照按钮
@property (nonatomic, strong)UIButton *tutorialButton; //引导按钮
@property (nonatomic, strong)UIButton *bottomNormalButton; //切换成正常拍照按钮
@property (nonatomic, strong)CHSpringView *springView; //弹簧视图
@property (nonatomic, strong)TakePhotoAlertView *alertView; //弹框提醒
@property (nonatomic, strong)CHImageLibraryButton *imageLibraryButton; //图片视图
@property (nonatomic, assign)BOOL isnewPhoto; //是否新拍摄照片

@end

@implementation CameraHomeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self startMotionManager];
    [self.captureSession startRunning];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.captureSession stopRunning];
    [self.motionManager stopDeviceMotionUpdates];
}

- (void)viewDidLayoutSubviews
{
    _viewPreviewLayer.frame = self.viewContainer.layer.bounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = HexColor(0x000000);
    
    _needShowAssistantLine = NO;
    
    _isnewPhoto = NO;
    
    [self getUserPhotoAuthorization];
    
    [self drawHorizonalLine];
    
    [self startDisplayLink];
    
    [self setupCamera];
    
    [self.view addSubview:self.bottomView];
    
    [self.bottomView addSubview:self.takePhotoButton];
    
    [self.bottomView addSubview:self.bottomNormalButton];
    
    [self.bottomView addSubview:self.imageLibraryButton];
    
    [self.viewContainer addSubview:self.springView];
    
    [self.viewContainer addSubview:self.alertView];
    
    [self createJQFMDBData];
    
    [self initNavigationView];
    
//#ifdef DEBUG
//    [self addDebugDevelopmentButton];
//#endif
    //添加引导图
//    [self mongolianLayer];
}

#pragma mark - 相机设置
- (void)setupCamera
{
    //初始化会话
    _captureSession=[[AVCaptureSession alloc]init];
    if ([_captureSession canSetSessionPreset:AVCaptureSessionPresetPhoto]) {//设置分辨率
        _captureSession.sessionPreset=AVCaptureSessionPresetPhoto;
    }
    //获得输入设备
    AVCaptureDevice *captureDevice=[self getCameraDeviceWithPosition:AVCaptureDevicePositionBack];//取得后置摄像头
    if (!captureDevice) {
        NSLog(@"取得后置摄像头时出现问题.");
        return;
    }
    
    NSError *error=nil;
    //根据输入设备初始化设备输入对象，用于获得输入数据
    _captureDeviceInput=[[AVCaptureDeviceInput alloc]initWithDevice:captureDevice error:&error];
    if (error) {
        NSLog(@"取得设备输入对象时出错，错误原因：%@",error.localizedDescription);
        return;
    }
    //初始化设备输出对象，用于获得输出数据
    _captureStillImageOutput=[[AVCaptureStillImageOutput alloc]init];
    NSDictionary *outputSettings = @{AVVideoCodecKey:AVVideoCodecJPEG};
    [_captureStillImageOutput setOutputSettings:outputSettings];//输出设置
    
    //将设备输入添加到会话中
    if ([_captureSession canAddInput:_captureDeviceInput]) {
        [_captureSession addInput:_captureDeviceInput];
    }
    
    //将设备输出添加到会话中
    if ([_captureSession canAddOutput:_captureStillImageOutput]) {
        [_captureSession addOutput:_captureStillImageOutput];
    }
    
    //创建视频预览层，用于实时展示摄像头状态
    _viewPreviewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.captureSession];
    
    CALayer *layer=self.viewContainer.layer;
    layer.masksToBounds=YES;
    
    _viewPreviewLayer.frame=layer.bounds;
    _viewPreviewLayer.videoGravity=AVLayerVideoGravityResizeAspectFill;//填充模式
    //将视频预览层添加到界面中
//    [layer addSublayer:_viewPreviewLayer];
//    [layer insertSublayer:_viewPreviewLayer below:self.view.layer];
    [layer insertSublayer:_viewPreviewLayer atIndex:0];
}

#pragma mark - 获取指定位置的摄像头
- (AVCaptureDevice *)getCameraDeviceWithPosition:(AVCaptureDevicePosition )position{
    NSArray *cameras= [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *camera in cameras) {
        if ([camera position]==position) {
            return camera;
        }
    }
    return nil;
}

#pragma mark - 开启一个定时器
- (void)startDisplayLink
{
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleDisplayLink)];
    self.displayLink.frameInterval = 2;
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)handleDisplayLink
{
    [self handleDeviceMotion:_motionManager.deviceMotion];
}

- (void)handleDeviceMotion:(CMDeviceMotion *)deviceMotion{
    double x = deviceMotion.gravity.x;
    double y = deviceMotion.gravity.y;
    double z = deviceMotion.gravity.z;
    [self.springView getGravityX:x gravityY:y gravity:z];
    [self.alertView getGravityX:x gravityY:y gravity:z];
    //角度回调
    weakSelf(wself);
    self.springView.getAngleToChangeCameraButtonStatus = ^(CameraStatus status) {
        if (status == cameraStatusHightLight) { //可拍照状态
            [wself.takePhotoButton setImage:[UIImage imageNamed:@"takePhoto_testse"] forState:UIControlStateNormal];
            wself.takePhotoButton.userInteractionEnabled = YES;
        } else if (status == cameraStatusNormal || status == cameraStatusMongolia) { //不可拍照状态
            [wself.takePhotoButton setImage:[UIImage imageNamed:@"takePhoto_testun"] forState:UIControlStateNormal];
            wself.takePhotoButton.userInteractionEnabled = NO;
        }
    };
    UIDeviceOrientation orientation;
    if (fabs(y) >= fabs(x)){
        if (y >= 0){
            orientation = UIDeviceOrientationPortraitUpsideDown;
        }
        else{
            orientation = UIDeviceOrientationPortrait;
        }
    }
    else{
        if (x >= 0){
            orientation = UIDeviceOrientationLandscapeRight;
        }
        else{
            orientation = UIDeviceOrientationLandscapeLeft;
        }
    }
    if (orientation != _deviceOrientation) {
        _deviceOrientation = orientation;
    }
    
    double tanAngle = atan(x/y);
    if (x >= 0 && y <= 0) {
        _deviceAngle = -tanAngle;
    }else if (x > 0 && y > 0){
        _deviceAngle = M_PI - tanAngle;
    }else if (x < 0 && y > 0){
        _deviceAngle = M_PI - tanAngle;
    }else if (x < 0 && y < 0){
        _deviceAngle = 2 * M_PI - tanAngle;
    }
    [self handleViewScope];
}

- (void)handleViewScope{
    _needShowAssistantLine = NO;
    for (int i = 0; i <= 4; i++) { //判断四个方向
        CGFloat gap = _deviceAngle - i * M_PI_2;
        if (fabs(gap) < 0.9 && fabs(_motionManager.deviceMotion.gravity.z) < 0.7) {
            _needShowAssistantLine = YES;
            break;
        }
    }
    if (_needShowAssistantLine) {
        [self drawHorizonalLine];
    }else{
        [self dismissHorizonalLine];
    }
}

- (void)dismissHorizonalLine{
    [_viewScopeLayer removeFromSuperlayer];
    _viewScopeLayer = nil;
}

#pragma mark - 水平线
- (void)drawHorizonalLine
{
    CALayer *containerLayer = self.viewContainer.layer;
    if (!_viewScopeLayer) {
        _viewScopeLayer = [[CALayer alloc] init];
        _viewScopeLayer.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5].CGColor;
        CALayer *maskLayer = [[CALayer alloc] init];
        CGFloat containerWidth = containerLayer.bounds.size.width;
        CGFloat containerHeight = containerLayer.bounds.size.height;
        _viewScopeLayer.frame = CGRectMake(0, 0, containerWidth, containerHeight);
        maskLayer.bounds = CGRectMake(0, 0, 2 * MAX(containerWidth, containerHeight), 2);
        maskLayer.position = CGPointMake(containerWidth / 2, containerHeight / 2);
        containerLayer.mask = _viewScopeLayer;
        maskLayer.backgroundColor = [UIColor whiteColor].CGColor;
        [_viewScopeLayer addSublayer: maskLayer];
    }
    
    CALayer* maskLayer = [[_viewScopeLayer sublayers]lastObject];
    maskLayer.affineTransform = CGAffineTransformMakeRotation(-_deviceAngle);
    ImageObject *obj = [[ImageObject alloc] init];
    CGSize size = [obj sizeOfRotationAngle:_deviceAngle FromSize:containerLayer.bounds.size deviceOrientation:_deviceOrientation];
    maskLayer.bounds = CGRectMake(0, 0, size.width, size.height);
}

#pragma mark - LAZY
#pragma mark 预览图层
- (UIView *)viewContainer
{
    if (!_viewContainer) {
        _viewContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 4 * SCREEN_WIDTH / 3)];
        _viewContainer.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_viewContainer];
    }
    return _viewContainer;
}

#pragma mark 拍照按钮图层
- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.viewContainer.ch_bottom, SCREEN_WIDTH, SCREEN_HEIGHT - self.viewContainer.ch_height)];
        _bottomView.backgroundColor = [UIColor blackColor];
    }
    return _bottomView;
}

#pragma mark 拍照按钮
- (UIButton *)takePhotoButton
{
    if (!_takePhotoButton) {
        _takePhotoButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kRealValue(64), kRealValue(64))];
        _takePhotoButton.center = CGPointMake(CGRectGetWidth(self.bottomView.bounds) / 2, CGRectGetHeight(self.bottomView.bounds) / 2 - kRealValue(30));
        [_takePhotoButton setImage:[UIImage imageNamed:@"takePhoto_testse"] forState:UIControlStateNormal];
        [_takePhotoButton addTarget:self action:@selector(takePhotoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _takePhotoButton;
}

- (void)takePhotoButtonClick:(UIButton *)btn
{
    //根据设备输出获得连接
    AVCaptureConnection *captureConnection=[self.captureStillImageOutput connectionWithMediaType:AVMediaTypeVideo];
    //根据连接取得设备输出的数据
    __block CGFloat angle = _deviceAngle;
    __weak __typeof(self) weakSelf = self;
    [self.captureStillImageOutput captureStillImageAsynchronouslyFromConnection:captureConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer) {
            NSData *imageData=[AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            UIImage *image=[UIImage imageWithData:imageData];
            
            if (self.needShowAssistantLine) {
                if (weakSelf.captureDeviceInput.device.position == AVCaptureDevicePositionFront) {
                    angle = 2*M_PI - angle;
                }
                ImageObject *obj = [[ImageObject alloc] init];
                image = [obj imageByStraightenImage:image andAngle:angle deviceOrientation:weakSelf.deviceOrientation shouldFlipRotation:weakSelf.captureDeviceInput.device.position == AVCaptureDevicePositionFront];
            }
            [self insertDataBase:[CHTime getNowTimeTimestamp2] photoData:[CHCompressImageManager zipNSDataWithImage:image]];
//            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil); //写入系统相册
        }
        
    }];
}

#pragma mark - 数据库的操作
#pragma mark 创建数据库
- (void)createJQFMDBData
{
    JQFMDB *db = [JQFMDB shareDatabase];
    [db jq_createTable:@"user" dicOrModel:[Personal class]]; //建表
    NSArray *array = [db jq_lookupTable:@"user" dicOrModel:[Personal class] whereFormat:nil]; //查找数据库中的全部数据
    NSArray *reversedArray = [[array reverseObjectEnumerator] allObjects]; //倒序输出
    if (reversedArray.count != 0) { //图库中有图片
        Personal *person = [reversedArray lastObject];
        _imageLibraryButton.userInteractionEnabled = YES;
        _imageLibraryButton.imageData = person.photoData;
    } else {
        _imageLibraryButton.userInteractionEnabled = NO;
    }
}


#pragma mark  插入数据库
- (void)insertDataBase:(NSString *)times photoData:(NSData *)data
{
    _imageLibraryButton.imageData = data;
    _imageLibraryButton.userInteractionEnabled = YES;
    _isnewPhoto = YES;
    NSString *lastTime = [NSObject readUserDefaultWithKey:@"lastTakePhotoTime"]; //从本地缓存中取出最后一张图片拍摄的时间
    NSString *group = [NSString readUserDefaultWithKey:@"TakePhotoGroupID"]; //从本地缓存中取出最后一组的ID
    
    //开辟线程，进行数据库插入，防止卡死
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        Personal *obj = [[Personal alloc] init];
        obj.photoTime = times;
        obj.photoData = data;
        obj.isDelete = NO;
        if (![NSString isBlank:group] && ![NSString isBlank:lastTime]) { //全新的数据库
            if ([times floatValue] - [lastTime floatValue] < 600) { //如果时间小于600s，则分为同一组
                obj.groupID = [group integerValue]; //时间小于600s则分为同一组
            } else {
                obj.groupID = [group integerValue] + 1; //时间大于600s则新增为新组
            }
        } else {
            obj.groupID = 1;
        }
        JQFMDB *db = [JQFMDB shareDatabase];
        [db jq_insertTable:@"user" dicOrModel:obj];
        
        [times writeUserDefaultWithKey:@"lastTakePhotoTime"]; //将拍照的最后一张图片存在本地(更新)
        [[NSString stringWithFormat:@"%ld", obj.groupID] writeUserDefaultWithKey:@"TakePhotoGroupID"]; //将拍照的最后一张图片分组ID取出放在本地
    });
}

#pragma mark 相册按钮
- (CHImageLibraryButton *)imageLibraryButton
{
    if (!_imageLibraryButton) {
        weakSelf(wself);
        _imageLibraryButton = [CHImageLibraryButton buttonWithFrame:CGRectMake(0, 0, kRealValue(50), kRealValue(50)) type:UIButtonTypeCustom andBlock:^(CHImageLibraryButton * button) {
            if (wself.isnewPhoto) {
                CHPhotoLibraryViewController *photoVC = [CHPhotoLibraryViewController new];
                photoVC.moment = @"";
                photoVC.type = enterTypeOnCamera;
                photoVC.reloadViewController = ^{
                    [wself backVCToOperation];
                };
                [wself.navigationController pushViewController:photoVC animated:YES];
            } else {
                CHPhotoLibraryListViewController *listVC = [CHPhotoLibraryListViewController new];
                listVC.backCameraViewController = ^{
                    [wself backVCToOperation];
                };
                [wself.navigationController pushViewController:listVC animated:YES];
            }
        }];
        _imageLibraryButton.center = CGPointMake(kRealValue(50), CGRectGetHeight(self.bottomView.bounds) / 2 - kRealValue(30));
    }
    return _imageLibraryButton;
}

- (void)backVCToOperation
{
    JQFMDB *db = [JQFMDB shareDatabase];
    NSArray *array = [db jq_lookupTable:@"user" dicOrModel:[Personal class] whereFormat:@"where pkid = '%ld'", [db lastInsertPrimaryKeyId:@"user"]];
    for (Personal *person in array) {
        self.imageLibraryButton.imageData = person.photoData;
    }
}

#pragma mark 弹簧视图
- (CHSpringView *)springView
{
    if (!_springView) {
        _springView = [[CHSpringView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        _springView.center = CGPointMake(CGRectGetWidth(self.viewContainer.bounds) / 2, CGRectGetHeight(self.viewContainer.bounds) / 2);
        _springView.backgroundColor = KClearColor;
    }
    return _springView;
}

- (TakePhotoAlertView *)alertView
{
    if (!_alertView) {
        CGFloat imageH = 4 * SCREEN_WIDTH / 3;
        _alertView = [[TakePhotoAlertView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, imageH + kTabBarHeight)];
        _alertView.backgroundColor = KClearColor;
    }
    return _alertView;
}

#pragma mark - 开启水平仪
- (void)startMotionManager
{
    _deviceOrientation = UIDeviceOrientationPortrait;
    _deviceAngle = 0;
    if (!_motionManager) {
        _motionManager = [[CMMotionManager alloc] init];
    }
    _motionManager.deviceMotionUpdateInterval = 1 / 20;
    if (_motionManager.deviceMotionAvailable) {
        [_motionManager startDeviceMotionUpdates];
    } else { //用户手机不支持水平仪
        [self AlertWithTitle:@"错误" message:@"很抱歉，您的手机不支持水平仪功能" andOthers:@[@"知道了"] animated:YES action:^(NSInteger index) {
            
        }];
        [self setMotionManager:nil];
    }
}

#pragma mark - 对导航栏进行操作
- (void)initNavigationView
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.tutorialButton];
}

#pragma mark 引导按钮
- (UIButton *)tutorialButton
{
    if (!_tutorialButton) {
        _tutorialButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kRealValue(25), kRealValue(25))];
        [_tutorialButton setImage:[UIImage imageNamed:@"home_icon_tutorial"] forState:UIControlStateNormal];
        [_tutorialButton addTarget:self action:@selector(clickTutorualButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tutorialButton;
}

- (void)clickTutorualButton
{
    CHTipsViewController *tipVC = [CHTipsViewController new];
    [self.navigationController pushViewController:tipVC animated:YES];
}

#pragma mark - 切换正常拍照按钮
- (UIButton *)bottomNormalButton
{
    if (!_bottomNormalButton) {
        _bottomNormalButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kRealValue(35), kRealValue(35))];
        [_bottomNormalButton setImage:[UIImage imageNamed:@"home_bottom_tutorial"] forState:UIControlStateNormal];
        [_bottomNormalButton setImage:[UIImage imageNamed:@"home_bottom_tutorial_selected"] forState:UIControlStateSelected];
        [_bottomNormalButton addTarget:self action:@selector(bottomViewNormalButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _bottomNormalButton.center = CGPointMake(self.bottomView.ch_width - kRealValue(50), CGRectGetHeight(self.bottomView.bounds) / 2 - kRealValue(30));
    }
    return _bottomNormalButton;
}

- (void)bottomViewNormalButtonClick:(UIButton *)btn
{
    [btn setSelected:!btn.isSelected];
    if (btn.selected) { //选中状态，即不需要辅助拍摄
        [self.motionManager stopDeviceMotionUpdates];
        self.displayLink.paused = YES;
        self.springView.hidden = YES;
        self.alertView.hidden = YES;
        [self dismissHorizonalLine];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.takePhotoButton.userInteractionEnabled = YES;
            [self.takePhotoButton setImage:[UIImage imageNamed:@"takePhoto_testse"] forState:UIControlStateNormal];
        });
    } else { //未选中状态, 需要辅助拍摄
        [self.motionManager startDeviceMotionUpdates];
        self.displayLink.paused = NO;
        self.springView.hidden = NO;
        self.alertView.hidden = NO;
    }
}

@end
