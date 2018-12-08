//
//  CHADPageView.m
//  CameraApp
//
//  Created by aieffei on 2018/11/30.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CHADPageView.h"

@interface CHADPageView ()
/**
 * 广告图片
 */
@property (nonatomic, strong)UIImageView *adView;
/**
 * 按钮
 */
@property (nonatomic, strong)UIButton *countButton;
/**
 * 计时器
 */
@property (nonatomic, strong)NSTimer *countTimer;
/**
 * 计数器
 */
@property (nonatomic, assign)int count;
/**
 * block
 */
@property (nonatomic, copy)tapBlock tapBlock;

@end

//广告显示时间
static int const showtime = 5;

@implementation CHADPageView

- (NSTimer *)countTimer
{
    if (!_countTimer) {
        _countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    }
    return _countTimer;
}

- (instancetype)initWithFrame:(CGRect)frame withTapBlock:(tapBlock)tapBlock
{
    if (self = [super initWithFrame:frame]) {
        //1.广告图片
        _adView = [[UIImageView alloc] initWithFrame:frame];
        _adView.userInteractionEnabled = YES;
        _adView.contentMode = UIViewContentModeScaleAspectFill;
        _adView.clipsToBounds = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToAd)];
        [_adView addGestureRecognizer:tap];
        
        //2.跳过按钮
        CGFloat btnW = 60;
        CGFloat btnH = 30;
        _countButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - btnW - 24, kTopHeight, btnW, btnH)];
        [_countButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [_countButton setTitle:[NSString stringWithFormat:@"跳过%d", showtime] forState:UIControlStateNormal];
        _countButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_countButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _countButton.backgroundColor = [UIColor colorWithRed:38 /255.0 green:38 /255.0 blue:38 /255.0 alpha:0.6];
        _countButton.layer.cornerRadius = 4;
        
        [self addSubview:_adView];
        [self addSubview:_countButton];
        
        //判断沙盒中是否存在广告图片，如果存在，直接显示
        NSString *filePath = [self getFilePathWithImageName:[kUserDefaults valueForKey:adImageName]];
        BOOL isExist = [self isFileExistWithFilePath:filePath];
        if (isExist) { //图片存在
            [self setFilePath:filePath];
            self.tapBlock = tapBlock;
            [self show];
        }
        //2.无论沙盒中是否存在广告图片，都需要重新调用广告接口，判断广告是否更新
        [self getAdvertisingImage];
    }
    return self;
}

- (void)setFilePath:(NSString *)filePath
{
    _filePath = filePath;
    _adView.image = [UIImage imageWithContentsOfFile:filePath];
}

- (void)pushToAd
{
    [self dismiss];
    if (self.tapBlock) {
        self.tapBlock();
    }
}

- (void)countDown
{
    _count --;
    [_countButton setTitle:[NSString stringWithFormat:@"跳过%d", _count] forState:UIControlStateNormal];
    if (_count <= 0) {
        [self dismiss];
    }
}

- (void)show
{
    if (showtime <= 0) {
        return;
    }
    [self startTimer];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}

- (void)startTimer
{
    _count = showtime;
    [[NSRunLoop mainRunLoop] addTimer:self.countTimer forMode:NSRunLoopCommonModes];
}

- (void)dismiss
{
    [self.countTimer invalidate];
    self.countTimer = nil;
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - 判断文件是否存在
- (BOOL)isFileExistWithFilePath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = FALSE;
    return [fileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
}

/**
 *  初始化广告页面
 */
- (void)getAdvertisingImage
{
    
    NSArray *imageArray = @[@"http://imgsrc.baidu.com/forum/pic/item/9213b07eca80653846dc8fab97dda144ad348257.jpg",
                            @"http://pic.paopaoche.net/up/2012-2/20122220201612322865.png",
                            @"http://img5.pcpop.com/ArticleImages/picshow/0x0/20110801/2011080114495843125.jpg",
                            @"http://www.mangowed.com/uploads/allimg/130410/1-130410215449417.jpg"];
    NSString *imageUrl = imageArray[arc4random() % imageArray.count];
    
    NSArray *stringArr = [imageUrl componentsSeparatedByString:@"/"];
    NSString *imageName = stringArr.lastObject;
    
    // 拼接沙盒路径
    NSString *filePath = [self getFilePathWithImageName:imageName];
    BOOL isExist = [self isFileExistWithFilePath:filePath];
    if (!isExist){// 如果该图片不存在，则删除老图片，下载新图片
        
        [self downloadAdImageWithUrl:imageUrl imageName:imageName];
        
    }
    
    // TODO 请求广告接口
    
}

/**
 *  下载新图片
 */
- (void)downloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        UIImage *image = [UIImage imageWithData:data];
        
        NSString *filePath = [self getFilePathWithImageName:imageName]; // 保存文件的名称
        
        if ([UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]) {// 保存成功
            NSLog(@"广告页保存成功");
            [self deleteOldImage];
            [kUserDefaults setValue:imageName forKey:adImageName];
            [kUserDefaults synchronize];
            // 如果有广告链接，将广告链接也保存下来
        }else{
            NSLog(@"广告页保存失败");
        }
        
    });
}

/**
 *  删除旧图片
 */
- (void)deleteOldImage
{
    NSString *imageName = [kUserDefaults valueForKey:adImageName];
    if (imageName) {
        NSString *filePath = [self getFilePathWithImageName:imageName];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:filePath error:nil];
    }
}

/**
 *  根据图片名拼接文件路径
 */
- (NSString *)getFilePathWithImageName:(NSString *)imageName
{
    if (imageName) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imageName];
        
        return filePath;
    }
    
    return nil;
}

@end
